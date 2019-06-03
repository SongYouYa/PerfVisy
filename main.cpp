
#include <QGuiApplication>
#include <QtQuick>
#include <QDebug>
#include <iostream>
#include <iostream>
#include <ctime>
#include <chrono>
#include "themeloader.h"

//#include </home/_Project/ford-kipawa/ford-qt-hmi/arpQt/inc/themeloader.h>
#include <controls/themehelper.h>


int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    const QString appRootDir = app.applicationDirPath();
    QQmlContext *ctxt = engine.rootContext();
    // Add the plugin path from the TARGET as a search path for SYNC-specific
    // plugins (i.e. the libHMIControls).
#ifdef SYNC_TARGET_LOCATION_QMLPLUGINS
#define xstr(s) str(s)
#define str(s) #s
    QString qmlPluginPath = QStringLiteral(xstr(SYNC_TARGET_LOCATION_QMLPLUGINS));
    engine.addImportPath(qmlPluginPath);
#endif
   // qputenv("HMI_APP_THEME_BASE", QDir::toNativeSeparators(appRootDir + "/AppThemeData/8inch").toLatin1());
   // qputenv("HMI_THEME_BASE", QDir::toNativeSeparators(appRootDir + "/HMIThemeData").toLatin1());
    engine.rootContext()->setContextProperty("applicationDirPath", appRootDir);
   ctxt->setContextProperty("defaultGallery", qgetenv("HMI_DEFAULT_GALLERY"));
    // Expose context properties for system information
    QSysInfo systemInfo;
    ctxt->setContextProperty("buildCpuArchitecture", systemInfo.buildCpuArchitecture());
    ctxt->setContextProperty("currentCpuArchitecture", systemInfo.currentCpuArchitecture());
    ctxt->setContextProperty("buildAbi", systemInfo.buildAbi());
    ctxt->setContextProperty("kernelType", systemInfo.kernelType());
    ctxt->setContextProperty("kernelVersion", systemInfo.kernelVersion());
    ctxt->setContextProperty("productType", systemInfo.productType());
    ctxt->setContextProperty("productVersion", systemInfo.productVersion());
    ctxt->setContextProperty("prettyProductName", systemInfo.prettyProductName());
    ctxt->setContextProperty("machineHostName", systemInfo.machineHostName());

    // Expose context property for the process environment
    QProcessEnvironment processEnvironment = QProcessEnvironment::systemEnvironment();
    ctxt->setContextProperty("processEnvironment", processEnvironment.toStringList());
 QString qml2ImportPath;
    if(! qgetenv("QML2_IMPORT_PATH").isEmpty())
        qml2ImportPath += QString::fromLocal8Bit(qgetenv("QML2_IMPORT_PATH").constData()) +':';
// qputenv("QML2_IMPORT_PATH", QDir::toNativeSeparators(qml2ImportPath + (appRootDir + "/qml") + "/Keyboard/styles")).toLatin1());
    // Expose context property for the version of Qt used to compile the application
#ifdef BUILD_QT_VERSION
#define STRINGIFY(x) #x
#define STRINGIFYMACRO(y) STRINGIFY(y)
    ctxt->setContextProperty("buildQtVersion", STRINGIFYMACRO(BUILD_QT_VERSION));
#endif

    QString appThemePath = appRootDir + "/AppThemeData/8inch/Ford-MY20-nav";
    QString packageId ="com.telenav.sync.telenav-app";

   // using namespace std::chrono;
    //  steady_clock::time_point t1 = steady_clock::now();


    QPointer<ThemeLoader> themeLoader = new ThemeLoader();
    engine.rootContext()->setContextProperty("themeLoader", themeLoader);

    qInfo() << "Telenav App package id " << packageId;
    qInfo() << "Telenav  theme path " << appThemePath;

    themeLoader->loadAppTheme(packageId, appThemePath);

    ThemeHelper *inst = ThemeHelper::getInstance();

    if(inst) {
        std::cout << "create ThemeHelper success" << std::endl;
        inst->loadAppTheme(packageId, appThemePath);
    }
    else{
        std::cout << "create ThemeHelper failure" << std::endl;

    }


    engine.load(QUrl(QStringLiteral("qmlsrc/main.qml")));
    return app.exec();
}

