#ifndef RESUME_BACKEND_H
#define RESUME_BACKEND_H

#include <QObject>
#include <QString>
#include <QJsonObject>
#include <QJsonDocument>
#include <QVariantList>
#include <QVariantMap>

class ResumeBackend : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentLanguage READ currentLanguage WRITE setCurrentLanguage NOTIFY currentLanguageChanged)
    Q_PROPERTY(bool isRtl READ isRtl NOTIFY isRtlChanged)
    
    // Personal Details (dynamic based on currentLanguage)
    Q_PROPERTY(QString name READ name NOTIFY dataChanged)
    Q_PROPERTY(QString title READ title NOTIFY dataChanged)
    Q_PROPERTY(QString location READ location NOTIFY dataChanged)
    Q_PROPERTY(QString phone READ phone NOTIFY dataChanged)
    Q_PROPERTY(QString email READ email NOTIFY dataChanged)
    Q_PROPERTY(QString github READ github NOTIFY dataChanged)
    Q_PROPERTY(QString githubUrl READ githubUrl NOTIFY dataChanged)
    Q_PROPERTY(QString linkedin READ linkedin NOTIFY dataChanged)
    Q_PROPERTY(QString linkedinUrl READ linkedinUrl NOTIFY dataChanged)
    Q_PROPERTY(QString summary READ summary NOTIFY dataChanged)

    // Models & Collections (dynamic based on currentLanguage)
    Q_PROPERTY(QVariantList experience READ experience NOTIFY dataChanged)
    Q_PROPERTY(QVariantList education READ education NOTIFY dataChanged)
    Q_PROPERTY(QVariantList skills READ skills NOTIFY dataChanged)
    Q_PROPERTY(QVariantList languages READ languages NOTIFY dataChanged)
    
    // UI Label Translations
    Q_PROPERTY(QVariantMap ui READ ui NOTIFY dataChanged)

public:
    explicit ResumeBackend(QObject *parent = nullptr);

    QString currentLanguage() const;
    void setCurrentLanguage(const QString &lang);
    bool isRtl() const;

    QString name() const;
    QString title() const;
    QString location() const;
    QString phone() const;
    QString email() const;
    QString github() const;
    QString githubUrl() const;
    QString linkedin() const;
    QString linkedinUrl() const;
    QString summary() const;

    QVariantList experience() const;
    QVariantList education() const;
    QVariantList skills() const;
    QVariantList languages() const;
    QVariantMap ui() const;

    Q_INVOKABLE void toggleLanguage();
    Q_INVOKABLE QVariantList getSourceFiles() const;
    Q_INVOKABLE QString getSourceFileContent(const QString &path) const;
    Q_INVOKABLE void copyToClipboard(const QString &text) const;

signals:
    void currentLanguageChanged();
    void isRtlChanged();
    void dataChanged();

private:
    void loadResumeData();
    QJsonObject getActiveData() const;

    QString m_currentLanguage;
    QJsonObject m_rootJson;
};

#endif // RESUME_BACKEND_H
