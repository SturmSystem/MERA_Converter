/****************************************************************************
** Meta object code from reading C++ file 'appengine.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.2.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../appengine.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'appengine.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.2.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_AppEngine_t {
    const uint offsetsAndSize[28];
    char stringdata0[147];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(offsetof(qt_meta_stringdata_AppEngine_t, stringdata0) + ofs), len 
static const qt_meta_stringdata_AppEngine_t qt_meta_stringdata_AppEngine = {
    {
QT_MOC_LITERAL(0, 9), // "AppEngine"
QT_MOC_LITERAL(10, 13), // "folderChanged"
QT_MOC_LITERAL(24, 0), // ""
QT_MOC_LITERAL(25, 6), // "folder"
QT_MOC_LITERAL(32, 10), // "openFolder"
QT_MOC_LITERAL(43, 9), // "getFolder"
QT_MOC_LITERAL(53, 11), // "chooseFiles"
QT_MOC_LITERAL(65, 10), // "fileChosen"
QT_MOC_LITERAL(76, 8), // "addFiles"
QT_MOC_LITERAL(85, 11), // "nameChanged"
QT_MOC_LITERAL(97, 18), // "currentFileChanged"
QT_MOC_LITERAL(116, 7), // "addLine"
QT_MOC_LITERAL(124, 10), // "removeFile"
QT_MOC_LITERAL(135, 11) // "clearScreen"

    },
    "AppEngine\0folderChanged\0\0folder\0"
    "openFolder\0getFolder\0chooseFiles\0"
    "fileChosen\0addFiles\0nameChanged\0"
    "currentFileChanged\0addLine\0removeFile\0"
    "clearScreen"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_AppEngine[] = {

 // content:
      10,       // revision
       0,       // classname
       0,    0, // classinfo
      11,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      11,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    1,   80,    2, 0x06,    1 /* Public */,
       4,    0,   83,    2, 0x06,    3 /* Public */,
       5,    0,   84,    2, 0x06,    4 /* Public */,
       6,    0,   85,    2, 0x06,    5 /* Public */,
       7,    1,   86,    2, 0x06,    6 /* Public */,
       8,    0,   89,    2, 0x06,    8 /* Public */,
       9,    1,   90,    2, 0x06,    9 /* Public */,
      10,    1,   93,    2, 0x06,   11 /* Public */,
      11,    1,   96,    2, 0x06,   13 /* Public */,
      12,    1,   99,    2, 0x06,   15 /* Public */,
      13,    0,  102,    2, 0x06,   17 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void, QMetaType::Int,    2,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void, QMetaType::Int,    2,
    QMetaType::Void,

       0        // eod
};

void AppEngine::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<AppEngine *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->folderChanged((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 1: _t->openFolder(); break;
        case 2: _t->getFolder(); break;
        case 3: _t->chooseFiles(); break;
        case 4: _t->fileChosen((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 5: _t->addFiles(); break;
        case 6: _t->nameChanged((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 7: _t->currentFileChanged((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 8: _t->addLine((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 9: _t->removeFile((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 10: _t->clearScreen(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (AppEngine::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AppEngine::folderChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (AppEngine::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AppEngine::openFolder)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (AppEngine::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AppEngine::getFolder)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (AppEngine::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AppEngine::chooseFiles)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (AppEngine::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AppEngine::fileChosen)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (AppEngine::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AppEngine::addFiles)) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (AppEngine::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AppEngine::nameChanged)) {
                *result = 6;
                return;
            }
        }
        {
            using _t = void (AppEngine::*)(int );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AppEngine::currentFileChanged)) {
                *result = 7;
                return;
            }
        }
        {
            using _t = void (AppEngine::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AppEngine::addLine)) {
                *result = 8;
                return;
            }
        }
        {
            using _t = void (AppEngine::*)(int );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AppEngine::removeFile)) {
                *result = 9;
                return;
            }
        }
        {
            using _t = void (AppEngine::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AppEngine::clearScreen)) {
                *result = 10;
                return;
            }
        }
    }
}

const QMetaObject AppEngine::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_AppEngine.offsetsAndSize,
    qt_meta_data_AppEngine,
    qt_static_metacall,
    nullptr,
qt_incomplete_metaTypeArray<qt_meta_stringdata_AppEngine_t
, QtPrivate::TypeAndForceComplete<AppEngine, std::true_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<QString, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<QString, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<QString, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<QString, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>



>,
    nullptr
} };


const QMetaObject *AppEngine::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *AppEngine::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_AppEngine.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int AppEngine::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 11)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 11)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 11;
    }
    return _id;
}

// SIGNAL 0
void AppEngine::folderChanged(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void AppEngine::openFolder()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void AppEngine::getFolder()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void AppEngine::chooseFiles()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void AppEngine::fileChosen(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void AppEngine::addFiles()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void AppEngine::nameChanged(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}

// SIGNAL 7
void AppEngine::currentFileChanged(int _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}

// SIGNAL 8
void AppEngine::addLine(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 8, _a);
}

// SIGNAL 9
void AppEngine::removeFile(int _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 9, _a);
}

// SIGNAL 10
void AppEngine::clearScreen()
{
    QMetaObject::activate(this, &staticMetaObject, 10, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
