module register
		#(parameter N = 16)
		(input		    Clk, Reset, Load,
		input			[N-1:0] D_In,
		output logic [N-1:0] Q_Out);
    reg [N-1:0] register; 
    always_ff @( posedge Clk ) begin 
        Q_Out <= register; 
    end
    always_comb begin
        register = Q_Out; 
        if(Reset) register = 0; 
        else if(Load) register = D_In; 
    end
endmodule

//8x16 general purpose register file
module regfile(input clk, reset, LD_REG,
               input [2:0] DR, SR2, SR1, //DR destination register (writing)
               input [15:0] D_In, 
               output logic [15:0] SR1_OUT, SR2_OUT);
    //https://stackoverflow.com/questions/41492818/optimizing-the-registerfile-code-in-systemverilog
    logic [7:0][15:0] register; //7:0 for 7 registers. addressed by 3 bits only 
    always_ff @( posedge clk ) begin 
        if(~reset)begin
//            genvar i; 
//            generate 
//                for (i=0; i<8; i++) begin: resetloop
//                    register[i] <= 16'h0000; 
//                end
//            endgenerate 
			register[0] <= 16'h0000; 
			register[1] <= 16'h0000; 
			register[2] <= 16'h0000; 
			register[3] <= 16'h0000; 
			register[4] <= 16'h0000; 
			register[5] <= 16'h0000; 
			register[6] <= 16'h0000; 
			register[7] <= 16'h0000; 
        end
        else if(LD_REG) begin
            case(DR)
                3'b000: register[0] <= D_In;
                3'b001: register[1] <= D_In;
                3'b010: register[2] <= D_In;
                3'b011: register[3] <= D_In;
                3'b100: register[4] <= D_In;
                3'b101: register[5] <= D_In;
                3'b110: register[6] <= D_In;
                3'b111: register[7] <= D_In;
            endcase
        end
    end
    always_comb begin
        case(SR1)
            3'b000: SR1_OUT = register[0];
            3'b001: SR1_OUT = register[1];
            3'b010: SR1_OUT = register[2];
            3'b011: SR1_OUT = register[3];
            3'b100: SR1_OUT = register[4];
            3'b101: SR1_OUT = register[5];
            3'b110: SR1_OUT = register[6];
            3'b111: SR1_OUT = register[7];
        endcase
    end
    always_comb begin
        case(SR2)
            3'b000: SR2_OUT = register[0];
            3'b001: SR2_OUT = register[1];
            3'b010: SR2_OUT = register[2];
            3'b011: SR2_OUT = register[3];
            3'b100: SR2_OUT = register[4];
            3'b101: SR2_OUT = register[5];
            3'b110: SR2_OUT = register[6];
            3'b111: SR2_OUT = register[7];
        endcase
    end
endmodule