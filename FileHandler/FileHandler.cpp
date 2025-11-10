#include "FileHandler.h"
#include <QDebug>

FileHandler::FileHandler() {
    qDebug() << "Hi from FileHandler()" ;
    return;
};

FileHandler::FileHandler(string str){
    fileName = str;
    this->open();
    if(file.is_open())
        qDebug() << "I opened file " << fileName.c_str() ;
    else
        qDebug() << "Couldn't open file" << fileName.c_str() ;
    return;
};

FileHandler::FileHandler(const FileHandler& handler)
    :
      fileName(handler.fileName),
      folder(handler.folder),
      firstLine(handler.firstLine),
      namesLine(handler.namesLine),
      unitsLine(handler.unitsLine),
      channels(handler.channels),
      names(handler.names),
      units(handler.units),
      outputFiles(handler.outputFiles),
      delimiter(handler.delimiter),
      skipChannels(handler.skipChannels),
      buf(handler.buf),
      num(handler.num)
{
    this->open();
}

FileHandler& FileHandler::operator=(const FileHandler& handler)
{
    fileName = handler.fileName;
    firstLine = handler.firstLine;
    namesLine = handler.namesLine;
    unitsLine = handler.unitsLine;
    channels = handler.channels;
    names = handler.names;
    units = handler.units;
    outputFiles = handler.outputFiles;
    delimiter = handler.delimiter;
    skipChannels = handler.skipChannels;
    buf = handler.buf;
    num = handler.num;
    folder = handler.folder;

    this->open();

    return *this;
}

FileHandler::~FileHandler(){
    if(file.is_open()){
        file.close();
        qDebug() << "I closed file " << fileName.c_str() ;
    }
    qDebug() << "outputFiles.size()=" << outputFiles.size() ;
    if(channels){
        for(int i=0; i<channels; i++){
            
            fclose(outputFiles.back());
            
            outputFiles.pop_back();
            qDebug() << "File " << names.back().c_str() << ".dat is closed" ;
            
            names.pop_back();
        }
    }

}

void FileHandler::start(){
    if(getChannelsData()){
        this->moveToThread(thread);
        thread->start();
    }
}

bool FileHandler::open(string name){
    if(!file.is_open()){
        if(name.size() > 0){
            fileName = name;
            file.open(fileName);
            return true;
        }
        else{
            qDebug() << "Empty file name" ;
            return false;
        }
    }
    else{
        qDebug() << "File is already open" ;
        return false;
    }
}

bool FileHandler::open(){
    if(!file.is_open()){
        if(fileName.size()>0){
            file.open(fileName);
            return true;
        }
        else{
            qDebug() << "Empty file name" ;
            return false;
        }
    }
    else{
        qDebug() << "File is already open" ;
        return false;
    }
}

bool FileHandler::is_open(){
    return file.is_open();
}

void FileHandler::setParameters(
        int first,
        int names,
        int units
    )
{

    qDebug() << "Set Parameters" ;

    firstLine = first;
    namesLine = names;
    unitsLine = units;

    qDebug() << "First Line : " << firstLine ;
    qDebug() << "Names Line : " << namesLine ;
    qDebug() << "Units Line : " << unitsLine ;
    return;
}

void FileHandler::setFolder(string folderName){
    folder = folderName;
}

void FileHandler::skipLines(int number){
    char str[1024];
    //qDebug() << "Skip " << number << " lines" ;
    for(int i=0; i<number; i++){
        file.getline(str, 1024, '\n');
    }
    return;
}

void FileHandler::resetFile(){
    //qDebug() << "Reset File" ;
    file.seekg(0, ios_base::beg);
    return;
}

void FileHandler::setDelimiter(char delim){
    delimiter = delim;
    return;
}

void FileHandler::skipColumns(int skip){
    skipChannels = skip;
    return;
};

void correctString(string& fileString){//Функция временная чисто чтобы исправить, что я дебил
    string newName;
    int Len = fileString.size();
    for(int i=0; i<Len; i++){
        if(fileString[i]=='/'){
            for(int j=i+1; j< Len; j++){
                newName.push_back(fileString[j]);
            }
        }
    }
    fileString = newName;
}

void checkString(string& fileString){
    int Len = fileString.size();
    qDebug() << fileString.c_str();
    qDebug() << fileString.size();
    for(int i=0; i<Len; i++){
        if(fileString[i] == '/'){
            for(int j=0; j<Len-i; j++){
                qDebug() << "Pop letter: " << fileString.back();
                fileString.pop_back();
            }
            break;
        }
        qDebug() << fileString[i] << "!= '/'";
    }
};

bool FileHandler::getChannelsData(){
    qDebug() << "Get Channels Data" ;
    char str[1024];
    if(namesLine){
        skipLines(namesLine-1);
        //qDebug() << typeid(
        if(file.getline(str, 1024))
            parseNamesLine(str);
        else{
            return false;
        }
        //).name() ;
        resetFile();
    }
    else{
        qDebug() << "namesLine is not defined";
        char c = '\n';
        //char t = '/';
        int iter = fileName.size()-5;
        qDebug() << "file Name len" << fileName.size();
        string name;
        //strcmp(&c,&t)
        while(c!='/'){
            c = fileName.c_str()[iter];
            qDebug() << c;
            name.push_back(c);
            iter--;
            if(iter == -100)
                break;
        }
        name.pop_back();
        qDebug() << "Name length " << name.size();
        string finalName;
        for(int i=name.size()-1; i>-1; i--){
            finalName.push_back(name.c_str()[i]);
        }
        names.push_back(finalName);
        channels+=1;
        qDebug() << names[0].c_str();
    }
    if(unitsLine){
        skipLines(unitsLine-1);
        if(file.getline(str, 1024))
            parseUnitsLine(str);
        else
            return false;
        resetFile();
    }

    //CKECK STRING IS HERE-------------------------
    for(int i=0; i<names.size(); i++){
        //correctString(names[i]); //временная функция, надо удалить
        checkString(names[i]);
    }
    //----------------------------------------------

    if(skipChannels){
        if(namesLine)
            names.pop_front();
        if(unitsLine)
            units.pop_front();
    }
    if(namesLine)
        channels -= skipChannels;
    qDebug() << "Channels: " << channels ;
    qDebug() << "Skip channels: " << skipChannels ;
    
    for(int i=0; i<channels; i++){
        openFile(names[i]);
    }

    return true;
}

void FileHandler::openFile(string name){
    FILE* out;
    string outName = (folder+"/"+name+".dat");
    out = fopen(outName.c_str(), "wb+");
    outputFiles.push_back(out);
    qDebug() << "File " << outName.c_str() << " is opened" ;
}

void FileHandler::parseNamesLine(string str){
    stringstream line(str);
    string name;
    while(getline(line, name, delimiter)){
        qDebug() << "Name: "<< name.c_str() << ";" ;
        names.push_back(name);
        channels+=1;
    }
    //qDebug() << "Channels amount " << channels ;
    return;
}

void FileHandler::parseUnitsLine(string str){
    stringstream line(str);
    string unit;
    while(getline(line, unit, delimiter)){
        qDebug() << "Unit: " << unit.c_str() << ";" ;
        units.push_back(unit);
    }
    return;
}

bool FileHandler::parseLine(){
    for(int i=0; i<skipChannels; i++){
        if(getline(file, buf, delimiter))
            {}//qDebug() << "Done" ;
        else
            return false;
    }
    for(int i=0; i<channels-1; i++){
        if(getline(file, buf, delimiter)){
            //qDebug() << "Num:" << buf << ";";
            try {
            //num = stod(buf);
            num2 = stof(buf);
            }
            catch(std::invalid_argument){
                qDebug() << "invalid argument";
                return false;
            }

            //fwrite(&num, sizeof(double), 1, outputFiles[i]);
            fwrite(&num2, sizeof(float), 1, outputFiles[i]);
        }
        else
            return false;
    }
    if(getline(file, buf, '\n')){
        //qDebug() << "Num:" << buf << ";";
        try{
            //num = stod(buf);
            num2 = stof(buf);
        }
        catch(std::invalid_argument){
            qDebug() << "invalid argument";
            return false;
        }

        //fwrite(&num, sizeof(double), 1, outputFiles.back());
        fwrite(&num2, sizeof(float), 1, outputFiles.back());
        //qDebug() ;
    }
    else
        return false;
    return true;
}

bool FileHandler::getLines(){
    long long int stringLen;
    long long int percentLinesAmount;
    long long int counter = 0;
    string checkString;
    skipLines(firstLine);
    getline(file, checkString);
    stringLen = checkString.size()+1;
    qDebug() << "Strlen is " << stringLen;
    resetFile();
    percentLinesAmount = (long long int)((double)AppEngine::getFileSize(QString(fileName.c_str()))/(double)stringLen);
    qDebug() << "Percent lines Amount " << percentLinesAmount;

    //percentLinesAmount = 5315;

    qDebug() << "Get Lines" ;
    skipLines(firstLine-1);

    while(parseLine()){
        counter++;
        //qDebug() << "Line parsed" << counter;
        if(counter == percentLinesAmount){
            //qDebug() << "Rise up the " << fileNumber << " file line";
            //qDebug() << "Num threads" <<  omp_get_thread_num();
            emit appEngine->riseUp(fileNumber);
            counter = 0;
            QCoreApplication::processEvents();
        }
    }
    qDebug() << "Done" ;
    resetFile();
    convertingDone = true;
    emit done();
    return true;
}
