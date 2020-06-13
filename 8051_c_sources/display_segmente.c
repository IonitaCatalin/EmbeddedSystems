#include <8051.h>
#include <math.h>

int main()
{
    
    char number;
    int digits[4];
    number=333;
    P0_7=1;
    P3=0;
    int counter=0;
    digits[0]=number%10;
    digits[1]=number/10%10;
    digits[2]=number/100%10;
    digits[3]=number/1000%10;
    while(1)
    {
       P3=counter<<3;
       switch(digits[counter])
        {
            case 1:
            {
                P1=0xF9;
                break;
            }
            case 2:
            {
                P1=0xA4;
                break;
            }
            case 3:
            {
                P1=0xB0;
                break;
            }
            case 4:
            {
                P1=0x99;
                break;
            }
            case 5:
            {
                P1=0x92;
                break;
            }
            case 6:
            {
                P1=0x82;
                break;
            }
            case 7:
            {
                P1=0xF8;
                break;
            }
            case 8:
            {
                P1=0x80;
                break;
            }
            case 9:
            {
                P1=0x90;
                break;
            }
            case 10:
            {
                P1=0b01111111;
                break;
            }
            
        }
       counter=(counter+1)%4;  
    }
    return 0;
}