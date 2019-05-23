#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <iostream>

#include <QMessageBox>
#include <QDir>
#include <QFileDialog>
#include <QDesktopWidget>
#include <QResizeEvent>
#include <QImage>

#include "externs.h"

MainWindow::MainWindow(QWidget *parent) :
        QMainWindow(parent),
        ui(new Ui::MainWindow),
        image(0), sizedImageCopy(0)
{
    ui->setupUi(this);

    setCentralWidget(ui->label);

    // Center Window on screen
    int w = QApplication::desktop()->width();
    int h = QApplication::desktop()->height();
    w -= width();
    h -= height();
    move (w/2, h/2);
}

MainWindow::~MainWindow()
{
    if (image) delete image;
    if (sizedImageCopy) delete sizedImageCopy;
    delete ui;
}

// Automatically generated code
void MainWindow::changeEvent(QEvent *e)
{
    QMainWindow::changeEvent(e);
    switch (e->type()) {
    case QEvent::LanguageChange:
        ui->retranslateUi(this);
        break;
    default:
        break;
    }
}

// This method is called whenever the user clicks the menu item for this task
void MainWindow::openFile()
{
    QImage tempImg;
//    QLabel * label = ui->label;

    QDir path("/usr/share/backgrounds");
    if (!path.exists()) path.setPath(QDir::currentPath());

    QString fileName = QFileDialog::getOpenFileName(this,"Datei öffnen", path.absolutePath());
    if (!fileName.isEmpty()) {
        tempImg.load(fileName);
        if (tempImg.isNull()) {
            QMessageBox::information(this,"Image Viewer",tr("Konnte %1 nicht öffnen!").arg(fileName));
            return;
        }

        // Having reached this point, we also have a valid image in tempImg
        // Convert into RGB32-format and display it for the user.
        image = new QImage(tempImg.convertToFormat(QImage::Format_RGB32));
        resize(image->width(), image->height()+ui->menuBar->height()+ui->statusBar->height());
        refreshImageView();
    }
}

// This method is called whenever the user clicks onto the info-menu-item
void MainWindow::showAboutBox()
{
    QMessageBox aboutBox(
            QMessageBox::Information,
            "PiqRig Information",
            "PiqRig Version 1.0\nInstitute for Automation of Complex Power Systems\nRWTH Aachen University\nCopyright 2014-2015");

    aboutBox.setModal(true);
    aboutBox.exec();
}

// The imagesize shall adapt to windowsize
void MainWindow::resizeEvent(QResizeEvent*)
{
    refreshImageView();
}

// whenever window or image are changed, the image has to be displayed in the right size again
void MainWindow::refreshImageView()
{
    if (image)
    {
        // Obtain a sized copy of the original image
        sizedImageCopy = new QImage(image->scaled(ui->label->size(), Qt::KeepAspectRatio));
        // Display it
        ui->label->setPixmap(QPixmap::fromImage(*sizedImageCopy));
        ui->label->adjustSize();
    }
}

void MainWindow::invertPicture()
{
    if (image)
    {
        // Call the inverting manipulation asm-function on the original image
        Invert(image->bits(), image->width(), image->height());
        // Display the changes on the windowsized copy
        refreshImageView();
    }
}

void MainWindow::blackWhitePicture()
{
    if (image)
    {
        // Call the black-and-white-converter asm-function on the original image
        ConvertToBlackWhite(image->bits(), image->width(), image->height());
        // Display the changes on the windowsized copy
        refreshImageView();
    }
}

void MainWindow::diagonalLinePicture()
{
    if (image)
    {
        // Let the asm-function draw a diagonal line on the original image
        DrawDiagonale(image->bits(), image->width(), image->height());
        // Display the changes on the windowsized copy
        refreshImageView();
    }
}
