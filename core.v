`timescale 1ns / 1ps 
module calcu16 (
  input clk,
  output LED0,
  output LED1,
  output LED2,
  output LED3,
  output LED4,
  output LED5,
  output LED6,
  output LED7);
    // Registers
    reg [0:7] regArray [0:7]; // General Purpose
    reg [0:7] pc = 0; // Program counter
    reg [0:15] ir; // Instruction register

    // Memory
    reg [0:25] memory [0:256];

    reg [0:4] opcode;
    reg [0:2] regSel1;
    reg [0:2] regSel2;
    reg [0:2] regSel3;
    reg [0:7] immediate;

    reg [0:16] tmp;

    integer i;

    initial begin
        // Set the registers values to 0
        for (i = 0; i < 8; i = i + 1)
            regArray[i] <= 0;
        
        $readmemb("program.bin", memory); // Load program
        
        // Uncomment for debugging
        // $dumpvars(7, regArray[0], regArray[1], regArray[2], regArray[3], regArray[4], regArray[5],
        //        regArray[6], regArray[7]);

        // $monitor("r0 = %b\nr1 = %b\nr2 = %b\nr3 = %b\nr4 = %b\nr5 = %b\nr6 = %b\nr7 = %b\n\n",
        //      regArray[0], regArray[1], regArray[2], regArray[3], regArray[4], regArray[5],
        //       regArray[6], regArray[7]);
    end

    always @(posedge clk) begin
        ir = memory[pc];
        //$display("ir=%b",ir);
        opcode = ir[0:4];
        regSel1 = ir[5:7];
        regSel2 = ir[9:11];
        regSel3 = ir[13:15];
        immediate = ir[8:15];

        pc = pc + 1;
        
        case (opcode)
            5'b00000: // ADD
                begin
                regArray[regSel1] = regArray[regSel2] + regArray[regSel3];
                $display("added");
                end
            5'b00001: // SUB
                regArray[regSel1] = regArray[regSel2] - regArray[regSel3];
            5'b00010: // AND
                regArray[regSel1] = regArray[regSel2] & regArray[regSel3];
            5'b00011: // OR
                regArray[regSel1] = regArray[regSel2] | regArray[regSel3];
            5'b00100: // XOR
                regArray[regSel1] = regArray[regSel2] ^ regArray[regSel3];
            5'b01000: // LDI
                begin
                regArray[regSel1] = immediate;
                $display("loaded");
                end
            5'b11111: // ADDI
                regArray[regSel1] = regArray[regSel2] + immediate;
            
        endcase
    end
    assign {LED0,LED1,LED2,LED3,LED4,LED5,LED6,LED7} = regArray[0][0:7];

endmodule