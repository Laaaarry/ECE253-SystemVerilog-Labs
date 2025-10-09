module v7404 (input logic pin1, pin3, pin5, pin9, pin11, pin13, 
            output logic pin2, pin4, pin6, pin8, pin10, pin12);
    assign pin2 = ~pin1;
    assign pin4 = ~pin3;
    assign pin6 = ~pin5;
    assign pin8 = ~pin9;
    assign pin10 = ~pin11;
    assign pin12 = ~pin13;
endmodule

module v7408 (input logic pin1, output logic pin3, input logic pin5, input
logic pin9, output logic pin11, input logic pin13, input logic pin2, input
logic pin4, output logic pin6, output logic pin8, input logic pin10, input
logic pin12);
    assign pin3 = pin1 & pin2;
    assign pin6 = pin4 & pin5;
    assign pin8 = pin9 & pin10;
    assign pin11 = pin12 & pin13;
endmodule

module v7432 (input logic pin1, output logic pin3, input logic pin5, input
logic pin9, output logic pin11, input logic pin13, input logic pin2, input
logic pin4, output logic pin6, output logic pin8, input logic pin10, input
logic pin12);
    assign pin3 = pin1 | pin2;
    assign pin6 = pin4 | pin5;
    assign pin8 = pin9 | pin10;
    assign pin11 = pin12 | pin13;
endmodule

module mux2to1(input logic x, y, s, output logic m);
    logic con1, con2, con3;
    v7404 u0(.pin1(s), .pin2(con1), 
            .pin3(), .pin4(), .pin5(), .pin6(), .pin9(), .pin8(), .pin11(), .pin10(), .pin13(), .pin12());
    v7408 u1(.pin1(x), .pin2(con1), .pin3(con2), .pin4(y), .pin5(s), .pin6(con3),
            .pin9(), .pin8(), .pin10(), .pin11(), .pin12(), .pin13());
    v7432 u2(.pin1(con2), .pin2(con3), .pin3(m),
            .pin4(), .pin5(), .pin6(), .pin9(), .pin8(), .pin10(), .pin11(), .pin12(), .pin13());
endmodule

// module mux(input logic [9:0] SW, output logic[9:0] LEDR);
//     mux2to1 u0(
//         .x(SW[0]),
//         .y(SW[1]),
//         .s(SW[9]),
//         .m(LEDR[0])
//         );
// endmodule