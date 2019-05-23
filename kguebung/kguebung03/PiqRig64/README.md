# PiqRiq

Bildverarbeitung mit Assembler

## 1. Implementiere fehlenden Code

- [ConvertToBlackWhite.asm](ConvertToBlackWhite.asm)
- [DrawDiagonale.asm](DrawDiagonale.asm)
- [Invert.asm](Invert.asm)

## 2. Compile

```bash
qmake
make
```

## 3. Ausführen

```bash
./PiqRiq Linux_logo.jpg
```

## 4. Ergebnise überprüfen

Nach erfolgreicher Ausführung liegen die bearbeiten Bilder als Bitmaps im gleichen Ordner:

```bash
ls -1 *.bmp
Linux_logo_black_white.bmp
Linux_logo_diagonal.bmp
Linux_logo_inverted.bmp
```

#### Original

![original](Linux_logo.jpg)

#### Schwarz & Weiß

![blackwhite](Linux_logo_black_white.bmp)

#### Diagonale Linie

![diagonal](Linux_logo_diagonal.bmp)

#### Invertiert

![original](Linux_logo_inverted.bmp)