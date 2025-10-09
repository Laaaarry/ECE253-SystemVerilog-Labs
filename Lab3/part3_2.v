`timescale 1ns/1ns

module register8(
    input clk,
    input reset_b,          // active-high synchronous reset
    input [7:0] d,
    output reg [7:0] q
);
    always @(posedge clk) begin
        if (reset_b)
            q <= 8'b00000000;
        else
            q <= d;
    end
endmodule

module part3(
    input Clock, Reset_b,
    input [3:0] Data,
    input [2:0] Function,
    output [7:0] ALU_reg_out
);
    reg [7:0] ALU_res;

    always @(*) begin
        case (Function)
            3'b000: ALU_res = Data + ALU_reg_out[3:0];   // Add
            3'b001: ALU_res = Data * ALU_reg_out[3:0];   // Multiply
            3'b010: ALU_res = ALU_reg_out[3:0] << Data;  // Shift
            3'b011: ALU_res = ALU_reg_out;               // Hold
            default: ALU_res = 8'b0;
        endcase
    end

    register8 u0(
        .clk(Clock),
        .reset_b(Reset_b),
        .d(ALU_res),
        .q(ALU_reg_out)
    );
endmodule

module part3_tb;
    reg Clock, Reset_b;
    reg [3:0] Data;
    reg [2:0] Function;
    wire [7:0] ALU_reg_out;

    part3 u0(
        .Clock(Clock),
        .Reset_b(Reset_b),
        .Data(Data),
        .Function(Function),
        .ALU_reg_out(ALU_reg_out)
    );
endmodule
