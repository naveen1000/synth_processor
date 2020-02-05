module pro (
  input clk,
  output LED1,
  output LED2,
  output LED3,
  output LED4,
  output LED5);
wire dclk;
clk_divider clkUUT(clk,dclk);
calcu16 proUUT(clk,LED1,LED2,LED3,LED4,LED5);

endmodule