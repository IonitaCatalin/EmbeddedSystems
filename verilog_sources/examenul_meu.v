module convertorBaza(Clk,X,R,Start,Ack);
    input Clk,Start;
    input [7:0]X;
    output reg [7:0]R;
    output reg Ack;
    reg [7:0]sir[4:0];
    reg [7:0]transResult,state,counter,transCounter,powerOfFour;
    always @(posedge Clk)
        if(state==0)
        begin
            if(Start==0)
            begin
                counter<=0;
                Ack<=0;
                state<=0;
            end
            else
            begin
                state<=1;
            end
        end
        else if(state==1)
        begin
            if(counter<4) begin
                sir[counter]=X;
                counter<=counter+1;
                state<=1;
            end
            else
            begin
                transCounter<=0;
                powerOfFour<=1;
                state<=2;
            end 
        end
        else if(state==2)
        begin
            if(transCounter<4)
            begin
                powerOfFour<=powerOfFour*4;
                transResult<=transResult+sir[transCounter]*powerOfFour;
                transCounter<=transCounter+1;
                state<=2;
            end
            else
            begin
                Ack<=1;
                R<=transResult;
                state<=3;
            end
        end
        else if(state==3)
        begin
            Ack<=0;
            state<=0;
        end
    initial begin
        counter<=0;
        state<=0;
        powerOfFour<=1;
    end
endmodule