# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-yiyaoba

CONFIG += sailfishapp

QT += dbus

SOURCES += src/harbour-yiyaoba.cpp

OTHER_FILES += qml/harbour-yiyaoba.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-yiyaoba.spec \
    rpm/harbour-yiyaoba.yaml \
    translations/*.ts \
    harbour-yiyaoba.desktop \
    qml/components/Panel.qml \
    qml/components/PanelView.qml \
    qml/js/md5.js \
    qml/py/__init__.py \
    qml/py/basedir.py \
    qml/py/main.py \
    qml/components/CacheImage.qml \
    qml/ui/NavigationPanel.qml \
    qml/components/HorizontalIconTextButton.qml \
    qml/components/UserAvatarHeader.qml \
    qml/components/AppGridComponet.qml \
    qml/components/AppListComponet.qml \
    qml/js/ApiCore.js \
    qml/js/ApiClass.js \
    qml/js/ApiMain.js \
    rpm/harbour-yiyaoba.changes \
    qml/pages/SignalCenter.qml \
    qml/cook/cooklist.qml \
    qml/cook/cookdetail.qml \
    qml/components/ImagePage.qml \
    qml/cook/cookcategory.qml \
    qml/top/toplist.qml \
    qml/top/topdetail.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-yiyaoba-de.ts \
                translations/harbour-yiyaoba-zh_CN.ts

