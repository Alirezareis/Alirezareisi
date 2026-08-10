/****************************************************************************
** Meta object code from reading C++ file 'resume_backend.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.7.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../resume_backend.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'resume_backend.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.7.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {

#ifdef QT_MOC_HAS_STRINGDATA
struct qt_meta_stringdata_CLASSResumeBackendENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSResumeBackendENDCLASS = QtMocHelpers::stringData(
    "ResumeBackend",
    "currentLanguageChanged",
    "",
    "isRtlChanged",
    "dataChanged",
    "toggleLanguage",
    "getSourceFiles",
    "getSourceFileContent",
    "path",
    "copyToClipboard",
    "text",
    "currentLanguage",
    "isRtl",
    "name",
    "title",
    "location",
    "phone",
    "email",
    "github",
    "githubUrl",
    "linkedin",
    "linkedinUrl",
    "summary",
    "experience",
    "education",
    "skills",
    "languages",
    "ui"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSResumeBackendENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
      17,   67, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,   56,    2, 0x06,   18 /* Public */,
       3,    0,   57,    2, 0x06,   19 /* Public */,
       4,    0,   58,    2, 0x06,   20 /* Public */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
       5,    0,   59,    2, 0x02,   21 /* Public */,
       6,    0,   60,    2, 0x102,   22 /* Public | MethodIsConst  */,
       7,    1,   61,    2, 0x102,   23 /* Public | MethodIsConst  */,
       9,    1,   64,    2, 0x102,   25 /* Public | MethodIsConst  */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::QVariantList,
    QMetaType::QString, QMetaType::QString,    8,
    QMetaType::Void, QMetaType::QString,   10,

 // properties: name, type, flags
      11, QMetaType::QString, 0x00015103, uint(0), 0,
      12, QMetaType::Bool, 0x00015001, uint(1), 0,
      13, QMetaType::QString, 0x00015001, uint(2), 0,
      14, QMetaType::QString, 0x00015001, uint(2), 0,
      15, QMetaType::QString, 0x00015001, uint(2), 0,
      16, QMetaType::QString, 0x00015001, uint(2), 0,
      17, QMetaType::QString, 0x00015001, uint(2), 0,
      18, QMetaType::QString, 0x00015001, uint(2), 0,
      19, QMetaType::QString, 0x00015001, uint(2), 0,
      20, QMetaType::QString, 0x00015001, uint(2), 0,
      21, QMetaType::QString, 0x00015001, uint(2), 0,
      22, QMetaType::QString, 0x00015001, uint(2), 0,
      23, QMetaType::QVariantList, 0x00015001, uint(2), 0,
      24, QMetaType::QVariantList, 0x00015001, uint(2), 0,
      25, QMetaType::QVariantList, 0x00015001, uint(2), 0,
      26, QMetaType::QVariantList, 0x00015001, uint(2), 0,
      27, QMetaType::QVariantMap, 0x00015001, uint(2), 0,

       0        // eod
};

Q_CONSTINIT const QMetaObject ResumeBackend::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSResumeBackendENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSResumeBackendENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSResumeBackendENDCLASS_t,
        // property 'currentLanguage'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'isRtl'
        QtPrivate::TypeAndForceComplete<bool, std::true_type>,
        // property 'name'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'title'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'location'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'phone'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'email'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'github'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'githubUrl'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'linkedin'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'linkedinUrl'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'summary'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'experience'
        QtPrivate::TypeAndForceComplete<QVariantList, std::true_type>,
        // property 'education'
        QtPrivate::TypeAndForceComplete<QVariantList, std::true_type>,
        // property 'skills'
        QtPrivate::TypeAndForceComplete<QVariantList, std::true_type>,
        // property 'languages'
        QtPrivate::TypeAndForceComplete<QVariantList, std::true_type>,
        // property 'ui'
        QtPrivate::TypeAndForceComplete<QVariantMap, std::true_type>,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<ResumeBackend, std::true_type>,
        // method 'currentLanguageChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'isRtlChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'dataChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'toggleLanguage'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'getSourceFiles'
        QtPrivate::TypeAndForceComplete<QVariantList, std::false_type>,
        // method 'getSourceFileContent'
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'copyToClipboard'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>
    >,
    nullptr
} };

void ResumeBackend::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<ResumeBackend *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->currentLanguageChanged(); break;
        case 1: _t->isRtlChanged(); break;
        case 2: _t->dataChanged(); break;
        case 3: _t->toggleLanguage(); break;
        case 4: { QVariantList _r = _t->getSourceFiles();
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 5: { QString _r = _t->getSourceFileContent((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 6: _t->copyToClipboard((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (ResumeBackend::*)();
            if (_t _q_method = &ResumeBackend::currentLanguageChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (ResumeBackend::*)();
            if (_t _q_method = &ResumeBackend::isRtlChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (ResumeBackend::*)();
            if (_t _q_method = &ResumeBackend::dataChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
    } else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<ResumeBackend *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->currentLanguage(); break;
        case 1: *reinterpret_cast< bool*>(_v) = _t->isRtl(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->name(); break;
        case 3: *reinterpret_cast< QString*>(_v) = _t->title(); break;
        case 4: *reinterpret_cast< QString*>(_v) = _t->location(); break;
        case 5: *reinterpret_cast< QString*>(_v) = _t->phone(); break;
        case 6: *reinterpret_cast< QString*>(_v) = _t->email(); break;
        case 7: *reinterpret_cast< QString*>(_v) = _t->github(); break;
        case 8: *reinterpret_cast< QString*>(_v) = _t->githubUrl(); break;
        case 9: *reinterpret_cast< QString*>(_v) = _t->linkedin(); break;
        case 10: *reinterpret_cast< QString*>(_v) = _t->linkedinUrl(); break;
        case 11: *reinterpret_cast< QString*>(_v) = _t->summary(); break;
        case 12: *reinterpret_cast< QVariantList*>(_v) = _t->experience(); break;
        case 13: *reinterpret_cast< QVariantList*>(_v) = _t->education(); break;
        case 14: *reinterpret_cast< QVariantList*>(_v) = _t->skills(); break;
        case 15: *reinterpret_cast< QVariantList*>(_v) = _t->languages(); break;
        case 16: *reinterpret_cast< QVariantMap*>(_v) = _t->ui(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<ResumeBackend *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setCurrentLanguage(*reinterpret_cast< QString*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    } else if (_c == QMetaObject::BindableProperty) {
    }
}

const QMetaObject *ResumeBackend::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *ResumeBackend::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSResumeBackendENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int ResumeBackend::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 7;
    }else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 17;
    }
    return _id;
}

// SIGNAL 0
void ResumeBackend::currentLanguageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void ResumeBackend::isRtlChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void ResumeBackend::dataChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP
