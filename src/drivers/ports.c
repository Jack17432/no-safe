unsigned char port_byte_in (unsigned short port) {
    /*
     * Querys given port number and returns associated byte.
     */

    unsigned char ret_val;
    __asm__("in %%dx, %%al" : "=a" (ret_val) : "d" (port));
    return ret_val;
}

void port_byte_out (unsigned short port, unsigned char data) {
    __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}

unsigned short port_word_in (unsigned short port) {
    unsigned short ret_val;
    __asm__("in %%dx, %%ax" : "=a" (ret_val) : "d" (port));
    return ret_val;
}

void port_word_out (unsigned short port, unsigned short data) {
    __asm__("out %%ax, %%dx" : : "a" (data), "d" (port));
}