module CMMDC(Clk,start,a,b,result);
    input Clk,start;
    input [7:0]a,b;
    reg [7:0]aReg,bReg;
    reg [3:0]stare;
    output reg [7:0]result;
    output reg ack;
    always @(posedge Clk)
    if(stare==0)
        if(start==0)
        begin
            ack<=0;
            stare<=0;
        end
        else
        begin    
            stare<=1;
            result<=0;
        end
    else if(stare==1)
        begin
            aReg<=a;
            bReg<=b;
            stare<=2;
        end
    else if(stare==2)
        begin
            if(aReg!=bReg)
            begin
                if(aReg<bReg)
                begin
                    bReg=bReg-aReg;
                    stare<=2;
                end
                else
                begin 
                    aReg=aReg-bReg;
                    stare<=2;
                end
            end
            else
            begin
                stare<=3;
            end
        end
    else if(stare==3)
        begin
            result<=aReg;
            ack<=1;
            stare<=4;
        end
    else if(stare==4)
        begin
            stare<=0;
        end
    initial
    begin
        stare<=0;
        ack<=0;
    end
endmodule