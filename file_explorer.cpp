#include "file_explorer.h"
#include <fstream>

using namespace std;


File_Explorer::File_Explorer(QWidget *parent)
{
    //QObject::connect(this, &File_Explorer::fileChosen,
    //                 this, &File_Explorer::getTextExample);
    QObject::connect(this, &File_Explorer::convertingDone,
                     this, &File_Explorer::createMERA);
}

File_Explorer::File_Explorer(AppEngine* applicationEngine, QWidget *parent)
    :
      app(applicationEngine)
{
    QObject::connect(this, &File_Explorer::convertingDone,
                     this, &File_Explorer::createMERA);
};

//"C:/Users/Fufai/Desktop/Programs/Qt/Projects/MERA Converter"
void File_Explorer::openFolder()
{
    QString newFolder = getExistingDirectory(nullptr, tr("Open Directory"), folder, QFileDialog::ShowDirsOnly);
    if(newFolder!=""){
        folder = newFolder;
        emit folderChanged(folder);
        qDebug() << "Chosen new folder : " << folder;
    }
}

/*void File_Explorer::chooseFiles(){
    QStringList newFiles = getOpenFileNames(nullptr, tr("Open Files"), folder, tr("Text files (*.txt)"));
    if(newFiles != QStringList()){
        files = newFiles;
        //model.setStringList(files);
        emit filesChosen(files);
        qDebug() << files;
    }
}*/

void File_Explorer::chooseFiles(){
    qDebug() << "Choose Files";
    QStringList newFiles = getOpenFileNames(nullptr, tr("Open Files"), folder, tr("Text files (*.txt)"));
    if(newFiles != QStringList()){
        examples.clear();
        files.clear();
        fileHandlers.clear();
        for(int i=0; i<newFiles.size(); i++)
            if(getTextExample(newFiles[i])){
                files.append(newFiles[i]);
                // ADD HERE FILEHANDLER DEFINITIONS
                fileHandlers.append(FileHandler(newFiles[i].toStdString()));
                // THIS IS FILEHANDLER DEFINITION ENDS
                emit fileChosen(newFiles[i]);
            }
        qDebug() << files;
    }
}
void File_Explorer::addFiles(){
    qDebug() << "Add Files";
    QStringList newFiles = getOpenFileNames(nullptr, tr("Open Files"), folder, tr("Text files (*.txt)"));
    if(newFiles != QStringList()){
        for(int i=0; i<newFiles.size(); i++)
            if(getTextExample(newFiles[i])){
                files.append(newFiles[i]);
                // ADD HERE FILEHANDLER DEFINITIONS
                fileHandlers.append(FileHandler(newFiles[i].toStdString()));
                // THIS IS FILEHANDLER DEFINITION ENDS
                emit fileChosen(newFiles[i]);
            }
        qDebug() << files;
    }
}

void File_Explorer::removeFile(int currentIndex){
    qDebug() << "Remove file: " << currentIndex << " " << files[currentIndex];
    examples.removeAt(currentIndex);
    files.removeAt(currentIndex);
    fileHandlers.removeAt(currentIndex);
}


bool File_Explorer::getTextExample(QString fileName){
    fstream file(fileName.toStdString());
    if(file.is_open()){
        qDebug() << "file: " << fileName;
        QStringList text;
        char str[256];
        for(int i=0; i<50; i++){
            file.getline(str, 256);
            text.append(str);
        }
        qDebug() << text;
        examples.append(text);
        file.close();
        return true;
    }
    else
        return false;
}

void File_Explorer::currentFileChanged(int currentIndex){
    qDebug() << currentIndex << " " << examples.size();
    if((examples.size()!=0)&&(currentIndex>=0)&&(currentIndex < examples.size()))
        for(int i=0; i < examples[currentIndex].size(); i++)
            emit addLine(examples[currentIndex].at(i));
}


void File_Explorer::startConverting(
        int firstLine,
        int namesLine,
        int unitsLine,
        int sampleRate,
        int skipColumns,
        QString delimiter
        )
{
    qDebug() << "Threads num" << omp_get_max_threads();
    int numThreads = (int)(omp_get_max_threads()/1.4);
    //numThreads = 4;
    qDebug() << "I wanna allocate " << numThreads;
//#pragma omp parallel num_threads(3);
    //omp_set_num_threads(3) - это не работает для MSVC, хотя мб и для MinGW, я не проверял

    qDebug() << "filleHandlers.size() = " << fileHandlers.size();

    qDebug() << "File set Parameters (" << firstLine << namesLine << unitsLine << ")";

    qDebug() << "File skip Columns " << skipColumns;

    qDebug() << "Set Deliiter" << delimiter.toStdString().c_str();


//#pragma omp parallel
//#pragma omp for nowait
            for(int i=0; i<fileHandlers.size(); i++){
                fileHandlers[i].sampleRate = sampleRate;
                qDebug() << "Thread num " << omp_get_thread_num() << " of " << omp_get_num_threads();
                fileHandlers[i].setAppEngine(app);
                fileHandlers[i].setFileNumber(i);
                fileHandlers[i].setFolder(folder.toStdString());
                fileHandlers[i].setParameters(firstLine, namesLine==-1?0:namesLine, unitsLine==-1?0:unitsLine);
                fileHandlers[i].skipColumns(skipColumns);
                fileHandlers[i].setDelimiter(delimiter.toStdString().c_str()[0]);


                fileHandlers[i].thread = new QThread;
                //QObject::connect(&fileHandlers[i], &FileHandler::start, fileHandlers[i].thread, &QThread::start);
                QObject::connect(fileHandlers[i].thread, &QThread::started, &fileHandlers[i], &FileHandler::getLines);
                QObject::connect(&fileHandlers[i], &FileHandler::done, fileHandlers[i].thread, &QThread::quit);
                QObject::connect(&fileHandlers[i], &FileHandler::done, this, &File_Explorer::checkForDone);
                if(i+numThreads<fileHandlers.size()){
                    QObject::connect(&fileHandlers[i], &FileHandler::done, &fileHandlers[i+numThreads], &FileHandler::start);
                }

                //qDebug() << "File set Parameters (" << firstLine << namesLine << unitsLine << ")";
                //qDebug() << "File skip Columns " << skipColumns;
                //qDebug() << "Set Deliiter" << delimiter.toStdString().c_str();
                //qDebug() << "Get Channels Data";
                //qDebug() << "Get Lines";
            }

            /*for(int i=0; i<fileHandlers.size(); i++){
                if(fileHandlers[i].getChannelsData()){
                    fileHandlers[i].moveToThread(fileHandlers[i].thread);
                    fileHandlers[i].thread->start();
                    //fileHandlers[i].getLines();
                }
            }*/
            for(int i=0; i<numThreads && i<fileHandlers.size(); i++){
                fileHandlers[i].start();
            }
            //if(fileHandlers.size()>0){
            //    fileHandlers[0].start();
            //}
}

void File_Explorer::createMERA(){
    string meraName = folder.toStdString() + "/" + name.toStdString() + ".MERA";
    qDebug() << "1";
    fstream meraFile(meraName, fstream::out);
    qDebug() << "2" << meraName.c_str();
    for(int i=0; i<fileHandlers.size(); i++){
        for(int j=0; j<fileHandlers[i].names.size(); j++){
            writeOut(meraFile, fileHandlers[i].names[j], fileHandlers[i].unitsLine==0?"1":fileHandlers[i].units[j], fileHandlers[i].sampleRate);
        }
    }
    qDebug() << "4";
    meraFile.close();
    qDebug() << "5";
}

void File_Explorer::writeOut(fstream& fileStream, string channelName, string unitName, int sampleRate){
    qDebug() << "3";
    fileStream << "[" + channelName + "]\nXUnits=c\nYUnits="+unitName+"\nStart=0\nFreq=" + to_string(sampleRate) + "\nk0=0\nk1=1.0\nYFormat=R4\nFunction=0\nXType=5\nYType=0\nXUnitsId=0x100000501\nYUnitsId=0x0\n";

            /*[file]
            DateTime=100000
            XUnits=с
            Start=0
            Step=5.0e-005
            Freq=100
            k0=0
            k1=1.000000000000
            YFormat=R8
            Function=0
            XType=5
            YType=0
            XUnitsId=0x100000501
            YUnitsId=0x0//*/
}
