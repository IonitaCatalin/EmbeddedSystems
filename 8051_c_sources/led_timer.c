#include <8051.h>
char time;
char durata_timp;
int main(){
    time=0;
    durata_timp=5;
    P3_0=0;
    P3_1=1;
    while(1){ 
        time=time+1;
        if(P2_0==1){
            P3=~P3;
            time=0;
        }
    }
    return 0;
}