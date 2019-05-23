#ifndef EXTERNS_H
#define EXTERNS_H


// This functions are defined in the *.asm files.
// They are located in this current file's folder.

// width and height shall be the width and height of the original image data in pixels
// bitmap-data is stored in 32 bits per pixel.
// Format:
//   0xAARRGGBB (hexadezimal): AA is not used in this case. It's just an empty byte,
//   while RR, GG and BB are byte-values of the colors red, green and blue, of course.
//   Don't forget about this aa-detail when impelenting the asm-functions!

extern "C" void Invert(void* bitmap, int width, int height);
extern "C" void DrawDiagonale(void* bitmap, int width, int height);
extern "C" void ConvertToBlackWhite(void* bitmap, int width, int height);

#endif // EXTERNS_H
