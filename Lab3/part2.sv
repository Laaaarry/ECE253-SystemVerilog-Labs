`timescale 1ns/1ns
module FA(input logic a, b, c_in,
        output logic s, c_out);
    assign s = a^b^c_in; // 3 input xor from in class method
    assign c_out = (a&b)|(a&c_in)|(b&c_in);
endmodule

module rippleadd(input logic [3:0] a, b, input logic c_in, 
            output logic [3:0] s, c_out);
    FA u0(.a(a[0]), .b(b[0]), .c_in(c_in), .s(s[0]), .c_out(c_out[0]));
    FA u1(.a(a[1]), .b(b[1]), .c_in(c_out[0]), .s(s[1]), .c_out(c_out[1]));
    FA u2(.a(a[2]), .b(b[2]), .c_in(c_out[1]), .s(s[2]), .c_out(c_out[2]));
    FA u3(.a(a[3]), .b(b[3]), .c_in(c_out[2]), .s(s[3]), .c_out(c_out[3]));
endmodule

module part2(input logic [3:0] A, B, input logic [1:0] Function, output logic [7:0] ALUout);
    logic [3:0] s = 4'b0000;
    logic [3:0] c_out = 4'b0000;
    rippleadd u0(.a(A), .b(B), .c_in(0), .s(s), .c_out(c_out));
    always_comb
    begin
        case (Function)
        0: begin
            ALUout = {3'b000, c_out[3], s};
        end
        1: begin
            if(|{A,B})
                ALUout = 8'b00000001;
            else
                ALUout = 8'b00000000;
        end
        2: begin
            if(&{A,B})
                ALUout = 8'b00000001;
            else
                ALUout = 8'b00000000;
        end
        3: begin
            ALUout = {A, B};
        end
        default
            ALUout = 8'b00000000;
        endcase
    end
endmodule

module part2_tb;
    logic [3:0] A, B;
    logic [7:0] ALUout;
    logic [1:0] Function;
    part2 u0(.A(A), .B(B), .Function(Function), .ALUout(ALUout));
endmodule