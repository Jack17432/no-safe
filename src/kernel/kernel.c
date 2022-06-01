#include "../drivers/ports.h"

void main() {
    /*
        To get screen cursor position the VGA control register (0x3d4) needs to be queried.
        if queried with 14 it will return cursor high byte and 15 for cursor low byte.

        The data will be returned on the VGA data register (0x3d5)
     */

    port_byte_out(0x3d4, 14);               // request high byte of cursor pos
    int cursor_pos = port_byte_in(0x3d5);   // get high byte of cursor pos
    cursor_pos = cursor_pos << 8;           // High byte is shifted over to allow the low byte to be added to it.

    port_byte_out(0x3d4, 15);               // request low byte of cursor pos  
    cursor_pos += port_byte_in(0x3d5);      // get low byte of cursor pos

    int offset_from_vga = cursor_pos * 2;

    char *vga = 0xb8000;
    vga[offset_from_vga] = 'X';
    vga[offset_from_vga + 1] = 0xF0;
}