#include "appengine.h"
#include <QDebug>
#include <QFileDialog>
#include <QApplication>

AppEngine::AppEngine(QObject *parent)
    : QObject{parent}
{
    model.setStringList(QStringList() << "a" << "b" << "c");
}

/*void AppEngine::launchButtonPressed()
{
    double a = 10.1, b=15.4;
    double result;
    result = just_sum(&a, &b);
    qDebug() << "Result is " << result ;
    QStringList fileNames = QFileDialog::getOpenFileNames(nullptr, tr("Open File"),
                                                    //QApplication::applicationDirPath(),
                                                    "C:/Users/Fufai/Desktop/Programs/Qt/Projects/MERA Converter",
                                                    tr("All Files (*.*);;Text files (*.txt);;Something else (*.pro)"));

    QString dirName = QFileDialog::getExistingDirectory(nullptr, tr("Open Directory"), "C:/Users/Fufai/Desktop/Programs/Qt/Projects/MERA Converter", QFileDialog::ShowDirsOnly);
    qDebug() << dirName;
    emit done(result);
}

double AppEngine::just_sum(double *a, double *b)
{
    qDebug() << "a is " << *a;
    qDebug() << "b is " << *b;
    return (*a) + (*b);
}*/
