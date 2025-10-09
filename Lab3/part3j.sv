module ALU (input logic [3:0] A, B, input logic [2:0] Function, output logic [7:0] ALUout); 
always_comb 
begin 
        case (Function) 
        3'b000: ALUout = A + B; 
        3'b001: ALUout = A * B; 
        3'b010: ALUout = B << A; 
        3'b011: ALUout = ALUout; 
        default: ALUout = 8'b0; 
        endcase 
    end 
endmodule 

module part3 (input logic Clock, Reset_b, input logic [3:0] Data, input logic [2:0] Function, 
            output logic [7:0] ALU_reg_out); 
        logic [7:0] ALU_out; 
        ALU u0 (Data, ALU_reg_out[3:0], Function, ALU_out); 

        always_ff @(posedge Clock) 
        begin 
            if (Reset_b)
            begin 
            ALU_reg_out <= 8'b0; 
            end 
                else 
            begin 
            ALU_reg_out = ALU_out; 
                end
            end 
endmodule