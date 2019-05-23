#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QImage>

namespace Ui {
    class MainWindow;
}

class MainWindow : public QMainWindow {
    Q_OBJECT
public:
    MainWindow(QWidget *parent = 0);
    ~MainWindow();

    // overloaded the resizeEvent-method to adapt imagesize
    virtual void resizeEvent(QResizeEvent * event);

protected:
    void changeEvent(QEvent *e);

protected slots:
// Those slots are connected with GUI-actions
    void openFile();
    void showAboutBox();

    void invertPicture();
    void blackWhitePicture();
    void diagonalLinePicture();

private:
    void refreshImageView();

    Ui::MainWindow *ui;

    // pointer on the original image the changes are made on
    QImage * image;
    // pointer on an image copy which fits to windowsize
    // will be refreshed when the original is changed
    QImage * sizedImageCopy;
};


#endif // MAINWINDOW_H
