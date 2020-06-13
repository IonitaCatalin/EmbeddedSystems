module MULTIPLY(Clk,start,a,b,rezultat,ack);
    input Clk,start;
    input [3:0]a,b;
    output reg[7:0]rezultat;
    output reg ack;
    /*
        O sa pastram valorile de input intrucat valorile de input se pot schimba
        de catre alt circuit lucru care creeza o situatie non-safe
    */
    reg [3:0]x,y;
    reg [2:0]stare;
    always @(posedge Clk)
        if(stare==0)
            if(start==0)
            begin
                ack<=0;
                stare<=0;   
            end
            else 
            begin
                x<=a;
                y<=b;
                rezultat<=0;
                stare<=1;
            end
        else if(stare==1)
            begin
                if(y==0)
                begin
                    ack<=1;
                    stare<=0;
                end
                else begin
                    rezultat<=rezultat+x;
                    y<=y-1;
                    stare<=1;
                end
            end
        initial
        begin
        /*
            Orice variabila neinitializata are valoare x nu zero la punerea sub tensiune
            starea va fi x nu 0.Riscam ca automatul sa nu evolueze spre nici o stare.
        */
            stare<=0;
            ack<=0;
        end
endmodule

module clock(c);
    output c;
    reg c;
    always #2 c=~c;
    initial c=0;
endmodule

module main();
    /*
        Semnale ale caror input provin de la utilizator
    */
    reg [3:0]a,b;
    reg start;
    /*
        Semnale pe care doar le citim 
    */
    wire clk,ack;
    wire [7:0]r;
    initial begin
        $dumpvars(0,main);
        $monitor("time:%d,start:%d,a:%d,b:%d,r:%d,ack:%d",$time,start,a,b,r,ack);
        start<=0;
        #2 a<=12;
        b<=6;
        #2 start<=1;
        #10 start<=0;
        #100 $finish();
    end
MULTIPLY mul(clk,start,a,b,r,ack);
clock c(clk);
endmodule
