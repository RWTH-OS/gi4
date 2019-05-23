#include <QApplication>

#include "mainwindow.h"
#include "commandline.h"

int main(int argc, char *argv[])
{
    if (argc == 1) {
        QApplication a(argc, argv);
        MainWindow w;
        w.show();
        return a.exec();
    }
    else {
        return CommandLine::process(argc, argv);
    }
}
