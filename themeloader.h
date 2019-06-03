#ifndef THEMELOADER_H
#define THEMELOADER_H
#include <QObject>
#include <QString>

#ifdef UNIT_TEST
#define private public
#define protected public
#endif

class ThemeLoader: public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isAppThemeLoaded READ isAppThemeLoaded)

public:
   /**
    * @brief Constructor
    *
    */
   ThemeLoader();

   ~ThemeLoader();

   /**
    * @brief loadAppTheme
    *
    * @param appThemePath - relative theme data folder path
    */
   void loadAppTheme(const QString& packageId, const QString& appThemePath);

   /**
    * @brief isAppThemeLoaded
    *
    * @return bool
    */

   bool isAppThemeLoaded() const;

signals:
   void appThemeLoaded();

private slots:
   void onThemeLoaded();
   void onThemeLoadingError(const QString &errorMessage, int errorCode);

private:
   bool m_appThemeLoaded;
};


#endif //THEMELOADER_H
