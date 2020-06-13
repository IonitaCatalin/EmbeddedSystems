#include <8051.h>

char i;
char nr;
int main(){
    char x[]={0b01111110,0b01111101,0b01111011,0b01110111};
    P0_7=1;
    P3=0;
    while(1)
    {
        nr=0;
        for(i=0;i<4;i++){
            P0=x[i];
            if(P0_4==0)
                nr=(3-i)*3+3;
            else if (P0_5==0)
                nr=(3-i)*3+2;
            else if (P0_6==0)
                nr=(3-i)*3+1;
            else if(nr!=0)
                P3=i<<3;
        }
       P1=nr;
    }
    return 0;
}