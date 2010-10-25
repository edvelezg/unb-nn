#include <QtGui/QApplication>
#include "mainwindow.h"
//#include <QxtGui>

// add this line to project properties: qmake -project &&  qmake &&  mingw32-make

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    return a.exec();
}

//Could not find mkspecs for your QMAKESPEC(win32-g++) after trying:
//C:/qt-greenhouse/Trolltech/Code_less_create_more/Trolltech/Code_less_create_more/Troll/4.6/qt\mkspecs
//Error processing project file: wrapper.pro

//To Solve this issue make sure to run the following exceutable
//C:\Qt\2010.05\qt\configure
