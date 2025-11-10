#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QCoreApplication>
#include <QQmlContext>
#include <QApplication>
#include "appengine.h"
#include "file_explorer.h"

int main(int argc, char *argv[])
{
    QApplication qapp(argc, argv);

    QQmlApplicationEngine engine;

    AppEngine appEngine;
    File_Explorer fileExplorer(&appEngine);

    engine.rootContext()->setContextProperty("app", &appEngine);
    engine.rootContext()->setContextProperty("filesListModel", &appEngine.model);

    engine.addImportPath("qrc:/QML/imports");

    const QUrl url(u"qrc:/QML/content/App.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &qapp, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    QObject::connect(&appEngine, &AppEngine::openFolder,
                     &fileExplorer, &File_Explorer::openFolder);
    QObject::connect(&fileExplorer, &File_Explorer::folderChanged,
                     &appEngine, &AppEngine::folderChanged);
    QObject::connect(&appEngine, &AppEngine::getFolder,
                     &fileExplorer, &File_Explorer::getFolder);
    QObject::connect(&appEngine, &AppEngine::chooseFiles,
                     &fileExplorer, &File_Explorer::chooseFiles);
    QObject::connect(&fileExplorer, &File_Explorer::fileChosen,
                     &appEngine, &AppEngine::fileChosen);
    QObject::connect(&appEngine, &AppEngine::addFiles,
                     &fileExplorer, &File_Explorer::addFiles);
    QObject::connect(&appEngine, &AppEngine::nameChanged,
                     &fileExplorer, &File_Explorer::nameChanged);
    QObject::connect(&appEngine, &AppEngine::currentFileChanged,
                     &fileExplorer, &File_Explorer::currentFileChanged);
    QObject::connect(&fileExplorer, &File_Explorer::addLine,
                     &appEngine, &AppEngine::addLine);
    QObject::connect(&appEngine, &AppEngine::removeFile,
                     &fileExplorer, &File_Explorer::removeFile);

    QObject::connect(&appEngine, &AppEngine::start,
                     &fileExplorer, &File_Explorer::startConverting);

    QObject::connect(&fileExplorer, &File_Explorer::convertingDone,
                     &appEngine, &AppEngine::convertingDone);

    engine.load(url);

    qapp.exec();

    return 0;
}

