/*
    this code verify wether the machine (processor) on which it's executed is on big or little endian
    we initialze a begin value on word and then we check if the first byte match.
    if true then "big endian"
    else "little endian"
*/
#include <stdio.h>
#include <stdint.h>

int main()
{
    unsigned short word = 0x1234;
    unsigned char *p = (unsigned char *) &word;

    if(p[0] == 0x12) printf("Your machine (processor) is on Big endian.\n");
    else printf("Your (processor) machine is on Little endian.");
    return 0;
}