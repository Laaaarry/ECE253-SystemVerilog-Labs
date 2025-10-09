`timescale 1ns/1ns

module ff(
    input logic clock, reset, d,
    output logic q
    );
    always_ff @(posedge clock)
    begin
        if(reset)
            q <= 0;
        else
            q <= d;
    end
endmodule

module part1(
    input logic clock, reset, ParallelLoadn, RotateRight, ASRight, 
    input logic [3:0] Data_IN, 
    output logic [3:0] Q);
    logic [3:0] next_d;
    always_comb
    begin
        if (ParallelLoadn)
            begin
                if (RotateRight)
                    begin
                        if (ASRight)
                            begin
                                next_d = {Q[3], Q[3:1]};
                            end
                        else
                            begin
                                next_d = {Q[0], Q[3:1]};
                            end
                    end
                else
                    begin
                        // next_d[3] = Q[2];
                        // next_d[2] = Q[1];
                        // next_d[1] = Q[0];
                        // next_d[0] = Q[3];
                        next_d = {Q[2:0], Q[3]};
                    end
            end
        else
            next_d = Data_IN;
    end
    ff u3(.clock(clock), .reset(reset), .d(next_d[3]), .q(Q[3]));
    ff u2(.clock(clock), .reset(reset), .d(next_d[2]), .q(Q[2]));
    ff u1(.clock(clock), .reset(reset), .d(next_d[1]), .q(Q[1]));
    ff u0(.clock(clock), .reset(reset), .d(next_d[0]), .q(Q[0]));
endmodule