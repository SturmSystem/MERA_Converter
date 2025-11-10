#ifndef APPENGINE_H
#define APPENGINE_H

#include <QObject>
#include <QStringListModel>
#include <QFileInfo>


class AppEngine : public QObject
{
    Q_OBJECT
public:
    QStringListModel model;
    explicit AppEngine(QObject *parent = nullptr);
    /*void filesChosen(QStringList files){
        model.setStringList(files);
        //emit filesChanged();
    }*/
    //Q_INVOKABLE void launchButtonPressed();
    //double just_sum(double*, double*);
    static long long int getFileSize(QString fileName){
            QFileInfo info(fileName);
            qDebug() << info.size();
            return (long long int)(0.01*info.size());
    }
signals:
    void folderChanged(QString folder);
    void openFolder();
    void getFolder();
    void chooseFiles();
    void fileChosen(QString);
    void addFiles();
    void nameChanged(QString);
    void currentFileChanged(int);
    void addLine(QString);
    void removeFile(int);
    void clearScreen();
    void start(
            int firstLine,
            int namesLine,
            int unitsLine,
            int sampleRate,
            int skipColumns,
            QString delimiter
            );
    void convertingDone();
    void riseUp(int);
};

#endif // APPENGINE_H
