module RANDOM(Clk,data);
    input [0:7]data;
    reg [0:7]mem[0:255];
endmodule

module clock(c);
output c;
reg c;
always #2 c=~c;
initial c=0;
endmodule


module main();
    reg [0:7]data;
    data<=127;
    RANDOM rand(clk,)
    clock ceas(clk);
end
endmodule