/*
    Circuit ROM
Intrari: <Clk> (semnal de ceas), <rd> (citire), <addr> (adresa - 8 biti).
Intrari/Iesiri: <data> (date - 8 biti).
a) Citire
Cat timp <rd> are valoarea 0, iesirea <data> este in inalta impedanta.
La momentul in care semnalul <rd> primeste valoarea 1, intrarea <addr> trebuie contina deja adresa dorita.
Cand semnalul <rd> primeste valoarea 1:
- Dupa 2 perioade de ceas, valoarea locatiei indicata de adresa <addr> este depusa pe iesirea <data>.
- Aceasta valoare se mentine alte 2 perioade de ceas, dupa care iesirea <data> trece din nou in inalta impedanta.
*/

module ROM(Clk,rd,addr,data);
    input Clk,rd;
    input [7:0]addr;
    output reg [7:0]data;
    reg [7:0]a;
    /*
        Continutul din memorie respectiva adresata prin adresa de memorie asociata
        cu adresa pe 8 biti
    */
    reg [7:0]mem[255:0];
    reg [3:0]stare;
    /*
        Actiuni care au loc intotdeauna,circuitul raspunde la comenzi si stari
        Frontul crescator al ceasului 
    */
    always @(posedge Clk)
        if(stare==0)
            if(rd==0)
            begin
                /*
                    Starea ramane 0 este indicat sa o reatribuim,
                    din motive de optimizare pentru compilator

                    !Cat timp <rd> are valoarea 0, iesirea <data> este in inalta impedanta.
                
                */
                //Inalta impedanta
                 data<=8'bzzzzzzzz;
                 stare<=0;
                
            end
            else
            begin
                a<=addr;
                stare<=1;
            end
        else if(stare==1)
            begin
                stare<=2;
            end
        else if(stare==2)
            begin
                data<=mem[a];
                stare<=3;
            /*Dupa 2 perioade de ceas, valoarea locatiei indicata de adresa <addr> este depusa pe iesirea <data>.*/
            end
        else if(stare==3)
            begin
                stare<=4;
            end
        else if(stare==4)
            begin
                data<=8'bzzzzzzzz;
                stare<=0;
            end
        integer i;
        initial
        begin
            stare<=0;
            data<=8'bzzzzzzzz;
            for(i=0;i<=255;i=i+1)
                mem[i]<=255-i;
        end
endmodule

module clock(c);
output reg c;
always
    #5 c<=~c;
initial
    c<=0;
endmodule

/*
    Circuit RAM
Intrari: <Clk> (semnal de ceas), <rd> (citire), <addr> (adresa - 8 biti).
Intrari/Iesiri: <data> (date - 8 biti).
a) Citire
Cat timp <rd> are valoarea 0, iesirea <data> este in inalta impedanta.
La momentul in care semnalul <rd> primeste valoarea 1, intrarea <addr> trebuie contina deja adresa dorita.
Cand semnalul <rd> primeste valoarea 1:
- Dupa 2 perioade de ceas, valoarea locatiei indicata de adresa <addr> este depusa pe iesirea <data>.
- Aceasta valoare se mentine alte 2 perioade de ceas, dupa care iesirea <data> trece din nou in inalta impedanta.
b) Scriere
La momentul in care semnalul <wr> primeste valoarea 1, intrarile <addr> si <data> trebuie contina deja valorile dorite.
Cand semnalul <wr> primeste valoarea 1:
- Dupa 2 perioade de ceas, valoarea locatiei indicata de adresa <addr> primeste valoare de pe intrarea <data>.
- Inca 2 perioade de ceas nu se poate realiza alta operatie de citire/scriere.
*/

module RAM(Clk,rd,wr,rd_addr,wr_addr,rd_data,wr_data);
    input Clk,rd,wr;
    input [7:0]rd_addr,wr_addr,wr_data;
    output reg [7:0]rd_data;
    reg [7:0]a;
    reg [7:0]b;
    reg [7:0]mem[255:0];
    reg [3:0]stare;
    reg [7:0]valoare;
 always @(posedge Clk)
        if(stare==0)
        begin
            if(rd==0)
            begin
                /*
                    Starea ramane 0 este indicat sa o reatribuim,
                    din motive de optimizare pentru compilator

                    !Cat timp <rd> are valoarea 0, iesirea <data> este in inalta impedanta.
                
                */
                //Inalta impedanta
                 rd_data<=8'bzzzzzzzz;
                 stare<=0;
            end
            else
            begin
                a<=rd_addr;
                stare<=1;
            end
            if(wr==0)
            begin
                stare<=0;
            end
            else
            begin
                b<=wr_addr;
                valoare<=wr_data;
                stare<=5;
            end
        end
        else if(stare==1)
            begin
                stare<=2;
            end
        else if(stare==2)
            begin
                rd_data<=mem[a];
                stare<=3;
            /*Dupa 2 perioade de ceas, valoarea locatiei indicata de adresa <addr> este depusa pe iesirea <data>.*/
            end
        else if(stare==3)
            begin
                stare<=4;
            end
        else if(stare==4)
            begin
                stare<=0;
            end
        else if(stare==5)
            begin
                stare<=6;
            end
        else if(stare==6)
        begin
            mem[b]<=valoare;
            stare<=7;
        end
        else if(stare==7)
        begin
            stare<=0;
        end
        integer i;
        initial
        begin
            stare<=0;
            rd_data=8'bzzzzzzzz;
            for(i=0;i<=255;i=i+1)
                mem[i]<=255-i;
        end
endmodule

module main();

reg read;
reg write;
reg [7:0]ad;
reg [7:0]in_ad;
wire [7:0]data;
reg [7:0]data_in;


//ROM r(clk,read,ad,data);
//module RAM(Clk,rd,wr,rd_addr,wr_addr,rd_data,wr_data);
RAM ram(clk,read,write,ad,in_ad,data,data_in);

// initial begin
//     $dumpvars(0,main);
//     $monitor("time:%d\tread:%d\taddress:%d\tdata:%d",$time,read,ad,data);
//     read<=0;
//     #2 ad<=73;
//     #2 read<=1;
//     #10 read<=0;
//     #100 $finish();
// end

// module RAM(Clk,rd,wr,rd_addr,wr_addr,rd_data,wr_data);

initial begin
    
    $dumpvars(0,main);
    //$monitor("time:%d\tread:%d\twrite:%d\taddress:%d\twrite_address:%d\tread_data:%d\twrite_data:%d\t",$time,read,write,ad,in_ad,data,data_in);
    $monitor("time:%d\tread:%d\twrite:%d\twrite_addr:%d\twrite_value:%d\tread_address:%d\tread_value:%d",$time,read,write,in_ad,data_in,ad,data);
    read<=0;
    // write<=0;
    // #2 data_in<=21;
    // #2 in_ad=73;
    // #2 write<=1;
    // #10 write=0;
    #2 ad<=73;
    #2 read<=1;
    #10 read<=0;
    #100 $finish();
    
end


clock ceas(clk);

endmodule