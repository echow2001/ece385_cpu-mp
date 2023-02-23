module mux2_1 
		#(parameter N = 16)
		(input				S,
		input					[N-1:0] A_In,
		input 				[N-1:0] B_In,
		output logic		[N-1:0] Q_Out);
	
	always_comb
		begin
				unique case(S)
						1'b0	:	Q_Out = A_In;
						1'b1	:	Q_Out = B_In;
				endcase
		end
endmodule

module mux4_1 
		#(parameter N = 16)
		(input [1:0] S,
		 input [N-1:0] A_In,
		 input [N-1:0] B_In,
		 input [N-1:0] C_In,
		 input [N-1:0] D_In,  
		 output logic [N-1:0] Q_Out);
	
	always_comb
		begin
				unique case(S)
						2'b00 :	Q_Out = A_In;
						2'b01 :	Q_Out = B_In;
						2'b10 :	Q_Out = C_In;
						2'b11 :	Q_Out = D_In;
				endcase
		end
endmodule

module mux8_1 
		#(parameter N = 16)
		(input [3:0] S,
		 input [N-1:0] A_In,
		 input [N-1:0] B_In,
		 input [N-1:0] C_In,
		 input [N-1:0] D_In, 		 
         input [N-1:0] E_In,
		 input [N-1:0] F_In,
		 input [N-1:0] AA_In,
		 input [N-1:0] AB_In,  
		 output logic [N-1:0] Q_Out);
	
	always_comb
		begin
				unique case(S)
						3'b000 :	Q_Out = A_In;
						3'b001 :	Q_Out = B_In;
						3'b010 :	Q_Out = C_In;
						3'b011 :	Q_Out = D_In;
						3'b100 :	Q_Out = E_In;
						3'b101 :	Q_Out = F_In;
						3'b110 :	Q_Out = AA_In;
						3'b111 :	Q_Out = AB_In;                        
				endcase
		end
endmodule


module mux4_1_onehot
		#(parameter N = 16)
		(input [3:0] S,
		 input [N-1:0] A_In,
		 input [N-1:0] B_In,
		 input [N-1:0] C_In,
		 input [N-1:0] D_In,  
		 output logic [N-1:0] Q_Out);
	
	always_comb
		begin
				unique case(S)
						4'b0001 :	Q_Out = A_In;
						4'b0010 :	Q_Out = B_In;
						4'b0100 :	Q_Out = C_In;
						4'b1000 :	Q_Out = D_In;
						default: Q_Out = 16'h0000; // must add default since we do not handle all cases explicitly
				endcase
		end
endmodule