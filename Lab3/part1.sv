`timescale 1ns/1ns
module FA(input logic a, b, c_in,
        output logic s, c_out);
    assign s = a^b^c_in; // 3 input xor from in class method
    assign c_out = (a&b)|(a&c_in)|(b&c_in);
endmodule

module part1(input logic [3:0] a, b, input logic c_in, 
            output logic [3:0] s, c_out);
    FA u0(.a(a[0]), .b(b[0]), .c_in(c_in), .s(s[0]), .c_out(c_out[0]));
    FA u1(.a(a[1]), .b(b[1]), .c_in(c_out[0]), .s(s[1]), .c_out(c_out[1]));
    FA u2(.a(a[2]), .b(b[2]), .c_in(c_out[1]), .s(s[2]), .c_out(c_out[2]));
    FA u3(.a(a[3]), .b(b[3]), .c_in(c_out[2]), .s(s[3]), .c_out(c_out[3]));
endmodule

module part1_tb;
    logic [3:0] a, b, s, c_out;
    logic c_in;
    part1 u0(.a(a), .b(b), .c_in(c_in), .s(s), .c_out(c_out));
endmodule