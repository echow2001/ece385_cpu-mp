module ALU(input [15:0] A_In, B_In, 
           input [1:0] K, 
           output logic [15:0] Out);
    always_comb begin
        Out = A_In; 
    end 
endmodule