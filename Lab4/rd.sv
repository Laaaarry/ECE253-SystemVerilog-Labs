`timescale 1ns/1ns
module RateDivider
#(parameter CLOCK_FREQUENCY=16)(
    input logic ClockIn,
    input logic Reset,
    input logic [1:0] Speed,
    output logic Enable
);
    // getting values
    localparam int unsigned max_bits = $clog2(4*CLOCK_FREQUENCY);
    logic [max_bits-1:0] cnt, reload;
    always_comb begin
        case(Speed)
            2'b00: reload = 0;
            2'b01: reload = CLOCK_FREQUENCY-1;
            2'b10: reload = (2*CLOCK_FREQUENCY)-1;
            2'b11: reload = (4*CLOCK_FREQUENCY)-1;
            default: reload = 0;
        endcase
    end
    
    // flipflop counter counts down
    always_ff @(posedge ClockIn or posedge Reset)
    if (Reset)
        begin
            cnt <= reload;
        end
    else if(cnt == 0)
        begin
            cnt <= reload;
        end
    else
        begin
            cnt <= cnt-1;
        end
    // enable clock output
    assign Enable = (cnt == 0);

endmodule

module RateDivider_tb;
    logic ClockIn, Reset;
    logic [1:0] Speed;
    logic Enable;

    // Instantiate DUT
    RateDivider #(.CLOCK_FREQUENCY(16) ) dut (
        .ClockIn(ClockIn),
        .Reset(Reset),
        .Speed(Speed),
        .Enable(Enable)
    );

endmodule
