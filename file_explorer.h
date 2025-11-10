#ifndef FILE_EXPLORER_H
#define FILE_EXPLORER_H

#include <QWidget>
#include <QFileDialog>
#include <QApplication>
#include <QDebug>
#include "FileHandler/FileHandler.h"
#include <omp.h>

#include "appengine.h"
#include <QThread>

#include <fstream>



class File_Explorer : public QFileDialog
{
    Q_OBJECT
public:
    explicit File_Explorer(QWidget *parent = nullptr);
    explicit File_Explorer(AppEngine*, QWidget *parent = nullptr);
    void openFolder();
    void getFolder(){
        emit folderChanged(folder);
    }
    void chooseFiles();
    void addFiles();
    void nameChanged(QString newName){
        name = newName;
        qDebug() << name;
    }
    void currentFileChanged(int);
    void removeFile(int);

    void checkForDone(){
        for(int i=0; i<fileHandlers.size(); i++){
            if(!fileHandlers[i].convertingDone)
                return;
            else
                continue;
        }
        emit convertingDone();
    }

    void startConverting(
            int firstLine,
            int namesLine,
            int unitsLine,
            int sampleRate,
            int skipColumns,
            QString delimiter
            );

    void createMERA();
    void writeOut(fstream& fileStream, string channelName, string unitName, int sampleRate);

signals:
    void folderChanged(QString);
    void fileChosen(QString);
    void addLine(QString);
    void convertingDone();

private:
    QString folder = QApplication::applicationDirPath();//"C:/Users/Fufai/Desktop/Programs/Qt/Projects/MERA_Converter";//
    QStringList files;
    QList<QStringList> examples;
    QList<FileHandler> fileHandlers;
    QString name = QString("Name");
    bool getTextExample(QString);

    AppEngine* app;
};

#endif // FILE_EXPLORER_H
