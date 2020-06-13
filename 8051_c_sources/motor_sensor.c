#include <8051.h>
char time;
char durata_timp;
int main(){
    time=0;
    durata_timp=5;
    /*
        Initializam directia de miscare a motorului pentru primele 5 unitati de timp de la executie
        P3_0=0 si P3_1=1 este echivalent cu sensul de rotatie de la stanga la dreapta
        Putem nega bitii din P3 pentru a inversa sensul de rotatie
    */
    P3_0=0;
    P3_1=1;
    while(1){ 
        time=time+1;
        if(time>=durata_timp){
            P3=~P3;
            time=0;
        }
    }
    return 0;
}