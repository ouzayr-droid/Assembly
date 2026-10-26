#include <stdio.h>

int count_bits(unsigned int data)
{
    int cnt = 0;

    while( data!=0)
    {
        data = data & (data-1);
        cnt++;
    }

    return cnt;
}

int main()
{
    int value = 12;

    int result = count_bits(value);

    printf(result);
    return 0;
}