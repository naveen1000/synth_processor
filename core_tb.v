`timescale 1ns / 1ps 

module calcu16_tb;
    reg clk;
    wire LED1;
    wire LED2;
    wire LED3;
    wire LED4;
    wire LED5;

    pro processor(clk,LED1,LED2,LED3,LED4,LED5);

    initial begin
        //$dumpfile("dump.vcd");
        clk <= 1;
        $monitor($time,"lights=%b %b %b %b %b",LED1,LED2,LED3,LED4,LED5);
        
        // Uncomment for debugging
        // $dumpvars(0, processor);

         #1000000 // Simulation time
         $finish;
    end

    always
        #1 clk = ~clk;
endmodule