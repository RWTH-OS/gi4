#include <QTextStream>
#include <QString>
#include <QImage>
#include <QFileInfo>

#include "externs.h"
#include "commandline.h"

static void saveImage(QImage &img, const QString &fileName, const char *fmt = "BMP")
{
    if (QFile::exists(fileName))
        QFile::remove(fileName);

    img.save(fileName, fmt);
}

int CommandLine::process(int argc, char *argv[])
{
    QImage tempImage;
    QImage originalImage;
    QImage invertedImage;
    QImage blackWhiteImage;
    QImage diagonalLineImage;

    if (argc != 2) {
        QTextStream(stdout) << "Usage: " << argv[0] << " filename" << endl;
        return -1;
    }

    QString fileName(argv[1]);
    QFileInfo fileInfo(fileName);

    tempImage.load(fileName);
    if (tempImage.isNull()) {
        QTextStream(stderr) << "Konnte " << fileName << " nicht öffnen!" << endl;
        return -1;
    }

    // Having reached this point, we also have a valid image in tempImage
    // Convert into RGB32-format and display it for the user.
    originalImage = QImage(tempImage.convertToFormat(QImage::Format_RGB32));

    // Invert image
    invertedImage = QImage(originalImage.copy());
    Invert(invertedImage.bits(), invertedImage.width(), invertedImage.height());
    saveImage(invertedImage, fileInfo.baseName() + "_inverted.bmp", "BMP");

    // Convert to black/white image
    blackWhiteImage = QImage(originalImage.copy());
    ConvertToBlackWhite(blackWhiteImage.bits(), blackWhiteImage.width(), blackWhiteImage.height());
    saveImage(blackWhiteImage, fileInfo.baseName() + "_black_white.bmp", "BMP");

    // Add diagonal line to image
    diagonalLineImage = QImage(originalImage.copy());
    DrawDiagonale(diagonalLineImage.bits(), diagonalLineImage.width(), diagonalLineImage.height());
    saveImage(diagonalLineImage, fileInfo.baseName() + "_diagonal.bmp", "BMP");

    return 0;
}
