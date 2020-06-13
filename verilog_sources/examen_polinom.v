module polinom(Clk,rd,wr,X,R);
    input Clk,rd;
    input [7:0]X[5:0];
    reg [7:0]a[5:0];
    reg [7:0]b[5:0];
    reg [7:0]stare;
    reg [7:0]counter;
     integer i;
     integer j;
     integer k;
    output reg wr;
    output reg [7:0]R;
    always @(posedge Clk)
    begin
        if(stare==0)
        begin 
            if(rd==0)
            begin
                stare<=0;
                wr<=0; 
            end
            else
            begin
                stare<=1; 
            end
        end
        else if(stare==1)
        begin
            //a<=X;
            for(i=0;i<5;i++)
                a[i]=X[i];
            stare<=2;
        end
        else if(stare==2)
        begin
            //b<=X;
            for(i=0;i<5;i++)
                a[i]=X[i];
            stare<=3;
        end
       
        else if(stare==3)
        begin
            
            for(i=0;i<5;i++)
                a[i]<=a[i]+b[i];
            stare<=4;
        end
        else if(stare==4)
        begin
            wr<=1;
            counter<=0;
        end
        else if(stare==5)
        begin
            if(counter<5)
            begin
                R<=a[counter];
                counter<=counter+1;
                stare<=5;
            end
            else 
            begin
                wr<=0;
                stare<=0;
            end
        end  
    end
    initial begin
        stare<=0;
        wr<=0;
    end
endmodule