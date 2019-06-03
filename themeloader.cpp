#include <QDebug>

#include "themeloader.h"
#ifndef UNIT_TEST
#include <controls/themehelper.h>
#endif

ThemeLoader::ThemeLoader()
    : m_appThemeLoaded(false)
{
#ifndef UNIT_TEST
    connect(ThemeHelper::getInstance(), &ThemeHelper::themeLoaded, this,
            &ThemeLoader::onThemeLoaded);
    connect(ThemeHelper::getInstance(), SIGNAL(themeLoadingError(const QString&, int)), this,
            SLOT(onThemeLoadingError(const QString&, int)));
#endif
}

ThemeLoader::~ThemeLoader()
{

}


bool ThemeLoader::isAppThemeLoaded() const
{
    return m_appThemeLoaded;
}

void ThemeLoader::loadAppTheme(const QString& packageId, const QString& appThemePath)
{        
    if (packageId.isEmpty()) { // windows will need to call it with empty package id
        qInfo() << "failed to get package id";
        //return;
    }


    qInfo() << "package id: " << packageId << ", AppThemeDataPath: " << appThemePath;
#ifndef UNIT_TEST
    ThemeHelper::getInstance()->loadAppTheme(packageId, appThemePath);
#endif
}

void  ThemeLoader::onThemeLoaded()
{
    m_appThemeLoaded = true;
    qInfo() << "Theme loaded successfully";
    emit appThemeLoaded();
}

void ThemeLoader::onThemeLoadingError(const QString &errorMessage, int errorCode)
{
    qInfo() << "Theme loading Error, error message: " << errorMessage << " error code:" << errorCode;
}

