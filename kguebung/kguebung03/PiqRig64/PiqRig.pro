#
# project file for PiqRig
#
TARGET = PiqRig
TEMPLATE = app
CONFIG += debug
QT += widgets

SOURCES += main.cpp \
    mainwindow.cpp \
    commandline.cpp
HEADERS += mainwindow.h \
    externs.h
FORMS += mainwindow.ui
OTHER_FILES += Invert.asm \
    DrawDiagonale.asm \
    ConvertToBlackWhite.asm
ASM_SRCS += $$OTHER_FILES

QMAKE_CFLAGS_RELEASE += -m64 -g
QMAKE_CXXFLAGS_RELEASE += -m64 -g
QMAKE_LFLAGS_RELEASE += -oformat=elf64-i386 -m64
QMAKE_EXTRA_COMPILERS += nasmproc

ASMFLAGS += -Wall
ASM = nasm

linux {
    ASMFLAGS += -f elf64 -F dwarf
}
macx {
    ASMFLAGS += -f macho64 --prefix _
}

nasmproc.input = ASM_SRCS
nasmproc.output = ${QMAKE_FILE_BASE}.o
nasmproc.commands = $$ASM $$ASMFLAGS -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_NAME}
