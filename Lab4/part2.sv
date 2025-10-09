`timescale 1ns/1ns
module RateDivider
#(parameter CLOCK_FREQUENCY=500)(
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

    assign Enable = (Speed == 2'b00) ? ClockIn :
                (cnt == 0) ? 1'b1 : 1'b0;
endmodule

module DisplayCounter (
    input logic Clock,
    input logic Reset,
    input logic EnableDC,
    output logic [3:0] CounterValue
);
    always_ff @(posedge Clock or Reset) begin
        if (Reset)
        begin
            CounterValue <= 4'b0000;
        end
        else if (EnableDC)
        begin
            CounterValue <= CounterValue + 1;
        end
        else
           CounterValue <= CounterValue;
    end
endmodule

module part2
#(parameter CLOCK_FREQUENCY=500)(
input logic ClockIn,
input logic Reset,
input logic [1:0] Speed,
output logic [3:0] CounterValue
);
logic enable;
RateDivider u0(.ClockIn(ClockIn), .Reset(Reset), .Speed(Speed), .Enable(enable));
DisplayCounter u1(.Clock(ClockIn), .Reset(Reset), .EnableDC(enable), .CounterValue(CounterValue));
endmodule