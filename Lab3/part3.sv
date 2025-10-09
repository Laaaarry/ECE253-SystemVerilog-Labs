`timescale 1ns/1ns
module register8(
        input logic clk,
        input logic reset_b,
        input logic [7:0] d,
        output logic [7:0] q
        );
    always_ff@(posedge clk)
    begin
        if (reset_b) 
            begin
            q<= 8'b00000000;
            end
        else 
            begin
            q <= d;
            end
    end
endmodule

module part3(
        input logic Clock, Reset_b, input logic [3:0] Data, input logic [2:0] Function, 
        output logic [7:0] ALU_reg_out);
        logic [7:0] ALU_res;
        always_comb
        begin
            case (Function)
                0: begin
                    ALU_res = Data + ALU_reg_out[3:0];
                end
                1: begin
                    ALU_res = Data * ALU_reg_out[3:0];
                end
                2: begin
                    ALU_res = ALU_reg_out[3:0] << Data;
                end
                3: begin
                    ALU_res = ALU_reg_out;
                end
                default: 
                    ALU_res = 8'b0;
            endcase
        end
        register8 u0(.clk(Clock), .reset_b(Reset_b), .d(ALU_res), .q(ALU_reg_out));
endmodule

module part3_tb;
    logic Clock, Reset_b;
    logic [3:0] Data;
    logic [2:0] Function;
    logic [7:0] ALU_reg_out;
    part3 u0(.Clock(Clock), .Reset_b(Reset_b), .Data(Data), .Function(Function), .ALU_reg_out(ALU_reg_out));
endmodule