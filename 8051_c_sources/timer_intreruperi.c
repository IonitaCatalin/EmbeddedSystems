#include <8051.h>
/*

    TCON

    Pagina8
    Discutii legate de compoenenta interna de timer
    Numaratorul se declanseaza cand TR0-1
    TR0 - Numaratorul pentru valoarea 1 v-a decrementa la un semnat periodic
    TF0 - FLAG care testeaza daca perioada de timp a expirat


    TMOD

    GATE - il punem pe 0 
    C/T - punem 0 pe acest bit pentru functionalitatea de timer(1 ar fi pentru counter)
    00 (M1M0) - PE 13 biti pentru decremenetare 
    01 (M1MO)- PE 16 biti pentru decrementare
    10(M1MO) - Pentru functia de autoincarcare

*/
char counter;

void f(void) __interrupt 1
{
    
    TH0=4;
    TL0=0;   
    counter++;
    P1=~counter;
}
//Fara generare de intreruperi
// int main()
// {
//     char counter;
//     counter=0;
//     TL0=0;
//     TH0=4;
//     TMOD=1;
//     P1=~counter;
//     TR0=1;
//     while(1)
//     {
//         while(1)
//         {
//             if(TF0==1)
//             {
//                 break;
//             }
//         }
//         counter++;
//         P1=~counter;
//         TH0=4;
//         TL0=0;   
//     }
//     return 0;
// }

int main()
{
    counter=0;
    TL0=0;
    TH0=4;
    TMOD=1;
    TR0=1;
    IE=130;
    P1=~counter;
    while(1)
    {
       
    }
    return 0;
}