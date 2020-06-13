module MUX0(Sel,I0,I1,E);
input Sel,I0,I1;
output E;
assign E=(I1&Sel)|(I0&~Sel);
endmodule

module MUX1(Sel,I0,I1,E);
input Sel,I0,I1;
output E;
wire x,y,z;
not n0(z,Sel);
and a1(x,I1,Sel);
and a0(y,I0,z);
or o0(E,x,y);
endmodule

module MUX2(Sel,I0,I1,E);
input Sel,I0,I1;
output E;
reg E;
always @(Sel,I0,I1)
E=(I1&Sel)|(I0&~Sel);
endmodule

module MUX3(Sel,I0,I1,E);
input Sel,I0,I1;
output E; reg E;
always @(Sel,I0,I1)
begin
if(Sel==0) E=I0;
else E=I1;
end
endmodule

module clock(c);
output c;
reg c;
always #2 c=~c;
initial c=0;
endmodule

module main();
    reg s,i0,i1;
    wire e0,e1,e2,e3;
    //Instante al modulului MUX0..3
    MUX0 m0(s,i0,i1,e0);
    MUX1 m1(s,i0,i1,e1);
    MUX2 m2(s,i0,i1,e2);
    MUX2 m3(s,i0,i1,e3);
    initial
        begin
            $monitor("Output:%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d",$time,s,i0,i1,e0,e1,e2,e3);
            s=1;
            i0=1;
            #5 i1=0;
        end
    wire cc;
    clock clk(cc);
    initial
        begin
            $display("\t\tTime\tcc");
            $monitor("%d\t%d",$time,cc);
            #50 $finish();
end
endmodule