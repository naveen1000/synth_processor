module clk_divider_tb;
reg clk=0;
wire div_clk;

clk_divider UUT(clk,div_clk);

always #5 clk = ~clk;

endmodule // 