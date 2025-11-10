#include <fstream>
#include <string>
#include <cstring>
#include <sstream>
#include <deque>
#include <cstdlib>
#include "appengine.h"
#include <QObject>

#include <omp.h>

#include <QCoreApplication>

#include <QThread>

using namespace std;

class FileHandler  : public QObject {
    Q_OBJECT
public:
    FileHandler();
    FileHandler(string);
    FileHandler(const FileHandler&);
    ~FileHandler();
    bool convertingDone = false;

    bool open(string);
    bool open();
    bool is_open();

    void setParameters(int first,int names,int units = 0);
    void setDelimiter(char);
    void setFolder(string);
    void skipColumns(int);
    void setFileNumber(int number){fileNumber=number; return;}
    void setAppEngine(AppEngine* app){
        appEngine = app;
    }

    bool getChannelsData();
    bool getLines();
    void start();

    FileHandler& operator=(const FileHandler&);

    deque<string> names;
    deque<string> units;
    int sampleRate;
    int unitsLine = 0;
    QThread *thread;

signals:
    void done();

private:
    string fileName;
    string folder;
    fstream file;
    int firstLine;
    int namesLine;
    int channels = 0;
    deque<FILE*> outputFiles;
    int fileNumber;
    long long int fileSize;
    AppEngine* appEngine;

    char delimiter = '\t';
    int skipChannels = 0;

    string buf;
    double num;
    float num2;
    
    void skipLines(int);
    void resetFile();
    void parseNamesLine(string);
    void parseUnitsLine(string);
    void openFile(string);
    void getStrlen();

    bool parseLine();
};
