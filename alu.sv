// LC-3 ALU module: 
// K       Out
// 00      ADD
// 01      AND
// 10      NOT
// 11      A 

module ALU(input [15:0] A_In, B_In, 
           input [1:0] K, 
           output logic [15:0] Out);
    always_comb begin
        case(K)
            2'b00: Out = A+B; 
            2'b01: Out = A&B; 
            2'b10: Out = ~A; 
            2'b11: Out = A; 
        endcase 
    end 
endmodule