//------------------------------------------------------------------------------
// Company:          UIUC ECE Dept.
// Engineer:         Stephen Kempf
//
// Create Date:    17:44:03 10/08/06
// Design Name:    ECE 385 Lab 6 Given Code - Incomplete ISDU
// Module Name:    ISDU - Behavioral
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 02-13-2017
//    Spring 2017 Distribution
//------------------------------------------------------------------------------

module ISDU (   input logic         Clk, 
									Reset,
									Run,
									Continue,
									
				input logic[3:0]    Opcode, 
				input logic         IR_5,
				input logic         IR_11,
				input logic         BEN,
				  
				output logic        LD_MAR,
									LD_MDR,
									LD_IR,
									LD_BEN,
									LD_CC,
									LD_REG,
									LD_PC,
									LD_LED, // for PAUSE instruction
									
				output logic        GatePC,
									GateMDR,
									GateALU,
									GateMARMUX,
									
				output logic [1:0]  PCMUX,
				output logic        DRMUX,
									SR1MUX,
									SR2MUX,
									ADDR1MUX,
				output logic [1:0]  ADDR2MUX,
									ALUK,
				  
				output logic        Mem_OE,
									Mem_WE
				);

	enum logic [4:0] {  Halted, 
						PauseIR1, 
						PauseIR2, 
						S_00,
						S_01, //
						S_04,
						S_05,
						S_06,
						S_07,
						S_09,
						S_12,
						S_16_1,
						S_16_2,
						S_16_3,
						S_16_4, 
						S_18, //
						S_21,
						S_22, 
						S_23,
						S_25_1,
						S_25_2,
						S_25_3,
						S_25_4, 
						S_27,
						S_32, //
						S_33_1, //
						S_33_2, //
						S_33_3, //
						S_35 // 
						}   State, Next_state;   // Internal state logic 
		
	always_ff @ (posedge Clk)
	begin
		if (Reset) 
			State <= Halted;
		else 
			State <= Next_state;
	end
   
	always_comb
	begin 
		// Default next state is staying at current state
		Next_state = State;
		
		// Default controls signal values
		LD_MAR = 1'b0;
		LD_MDR = 1'b0;
		LD_IR = 1'b0;
		LD_BEN = 1'b0;
		LD_CC = 1'b0;
		LD_REG = 1'b0;
		LD_PC = 1'b0;
		LD_LED = 1'b0;
		 
		GatePC = 1'b0;
		GateMDR = 1'b0;
		GateALU = 1'b0;
		GateMARMUX = 1'b0;
		 
		ALUK = 2'b00;
		 
		PCMUX = 2'b00;
		DRMUX = 1'b0;
		SR1MUX = 1'b0;
		SR2MUX = 1'b0;
		ADDR1MUX = 1'b0;
		ADDR2MUX = 2'b00;
		 
		Mem_OE = 1'b0;
		Mem_WE = 1'b0;
	
		// Assign next state
		unique case (State)
			Halted : 
				if (Run) 
					Next_state = S_18;                      
					//Next_state = PauseIR1; //pause after every S_18 for cp1                
			S_18 : 
				Next_state = S_33_1;
			// Any states involving SRAM require more than one clock cycles.
			// The exact number will be discussed in lecture.
			//add one memory waiting state for devbrd demo 
			//add state btwn 33_1 33_2 
			S_33_1 : 
				Next_state = S_33_2;
			S_33_2 : 
				Next_state = S_33_3;
			S_33_3 : 
				Next_state = S_35; 
			S_35 : Next_state = S_32; //Next_state = PauseIR1;
			// PauseIR1 and PauseIR2 are only for Week 1 such that TAs can see 
			// the values in IR.
			PauseIR1 : 
				if (~Continue) 
					Next_state = PauseIR1;
				else 
					Next_state = PauseIR2;
			PauseIR2 : 
				if (Continue) 
					Next_state = PauseIR2;
				else 
					Next_state = S_18;
			S_32 : 
				case (Opcode) //IR[15:12]
					4'b0001 : 
						Next_state = S_01; // add 
					4'b0101 : 
						Next_state = S_05; // and
					4'b1001 : 
						Next_state = S_09; // not
					4'b0000 : 
						Next_state = S_00; // br
					4'b1100 : 
						Next_state = S_12; // jmp
					4'b0100 : 
						Next_state = S_04; // jsr 
					4'b0110 : 
						Next_state = S_06; // ldr
					4'b0111 : 
						Next_state = S_07; // str
					4'b1101 : 
						Next_state = PauseIR1; // pause
					default : 
						Next_state = S_18;
						//Next_state = PauseIR1; //cp1 only
				endcase
			S_00: begin
				if(BEN) Next_state = S_22; 
				else Next_state = S_18; 
			end
			//S_01 : Next_state = S_18; //PauseIR1; 
			S_01, S_05, S_09, S_12, S_16_4, S_21, S_22, S_27 : Next_state = S_18; 
			S_04: Next_state = S_21; 
			S_06: Next_state = S_25_1; 
			S_07: Next_state = S_23; 
			S_16_1: Next_state = S_16_2;
			S_16_2: Next_state = S_16_3; 
			S_16_3: Next_state = S_16_4; 
			S_23: Next_state = S_16_1; 
			S_25_1: Next_state = S_25_2; 
			S_25_2: Next_state = S_25_3; 
			S_25_3: Next_state = S_25_4; 
			S_25_4: Next_state = S_27; 
			default : Next_state = S_18;
		endcase
		
		// Assign control signals based on current state
		case (State)
			Halted: ;
			S_18 : 
				begin 
					GatePC = 1'b1;
					LD_MAR = 1'b1;
					PCMUX = 2'b00;
					LD_PC = 1'b1;
				end
			S_33_1 : //MDR <= M 
				Mem_OE = 1'b1;
			S_33_2 : //MDR <= M 
				Mem_OE = 1'b1;
			S_33_3 : 
				begin 
					Mem_OE = 1'b1;
					LD_MDR = 1'b1;
				end
			S_35 : 
				begin 
					GateMDR = 1'b1;
					LD_IR = 1'b1;
				end
			PauseIR1: begin // LEDs <= ledVect12
				LD_LED = 1'b1; 
			end
			PauseIR2: ; // Wait on Continue
			S_32 : 
				LD_BEN = 1'b1;
			S_01 : begin //ADD R(DR) <= R(SR1) + R(SR2)
				SR2MUX = IR_5; // sel imm5, SR2_out
				ALUK = 2'b00; // alu_out = A + B
				GateALU = 1'b1;
				LD_REG = 1'b1;
				LD_CC = 1'b1; 
				SR1MUX = 1'b0; //IR[8:6] 
				DRMUX = 1'b1; 
			end
			S_00: LD_BEN = 1'b1; 
			S_04: begin
				GatePC = 1'b1; 
				LD_REG = 1'b1;
				DRMUX = 1'b0; // 111 R7 
			end
			S_05: begin //AND R(DR) <= R(SR1) & R(SR2)
				SR2MUX = IR_5;
				ALUK = 2'b01; // alu_out = A & B
				GateALU = 1'b1;
				LD_REG = 1'b1;
				LD_CC = 1'b1; 
				SR1MUX = 1'b0; //IR[8:6]
				DRMUX = 1'b1; //IR[11:9]
			end
			//base register B IR[8:6]
			S_06, S_07: begin //MAR <= B + off6 
				LD_MAR = 1'b1;
				SR1MUX = 1'b0; // IR[8:6]
				ADDR1MUX = 1'b1; //SR1_OUT
				ADDR2MUX = 2'b01; //offset6 s_ext IR[5:0] 
				GateMARMUX = 1'b1; // mux removed?? check this later 
			end
			S_09: begin //NOT R(DR) <= ~R(SR1)
				SR2MUX = IR_5; 
				ALUK = 2'b10; //alu_out = ~A
				GateALU = 1'b1; 
				LD_REG = 1'b1;
				LD_CC = 1'b1; 
				SR1MUX = 1'b0; //IR[8:6]
				DRMUX = 1'b1; //IR[11:9]
			end
			S_12: begin //JMP PC <=BaseR 
				SR1MUX = 1'b0; //IR[8:6]
				LD_PC = 1'b1; 
				PCMUX = 2'b01; //PC_alu_out
				ADDR2MUX = 2'b01; //IR[5:0]
				ADDR1MUX = 1'b1; //reg_SR1
			end
			S_16_1, S_16_2, S_16_3: Mem_WE = 1'b1; // M[MAR] <= MDR
			S_21: begin //PC<=PC+off11
				ADDR2MUX = 2'b11; // IR[10:0] off11
				PCMUX = 2'b01; // pc_branch 
				LD_PC = 1'b1; 
			end
			S_22: begin // PC <= PC + off9 
				ADDR2MUX = 2'b10; // IR[8:0] off9 
				PCMUX = 2'b01; // pc_branch
				LD_PC = 1'b1; 
			end
			//store : state1: MAR <= (BaseR + SEXT(offset6)) from ALU; MDR <= R(SR)
					//state2: M(MAR) <= MDR; -- assert Write Command on the RAM
					//SR source register IR[11:9]
			S_23: begin // MDR <= SR 
				ALUK = 2'b11; // A 
				SR1MUX = 1'b1; //IR[11:9]
				GateALU = 1'b1; 
				LD_MDR = 1'b1; 
			end
			//wait for memory to ready before loading MDR similar to given example in S_33
			S_25_1: Mem_OE = 1'b1; // MDR <= M[MAR] 
			S_25_2: Mem_OE = 1'b1; // MDR <= M[MAR] 
			S_25_3: begin // MDR <= M[MAR]
				Mem_OE = 1'b1;
				LD_MDR = 1'b1;
			end
			S_27: begin // DR <= MDR
				LD_CC = 1'b1; 
				DRMUX = 1'b1; //IR[11:9]
				GateMDR = 1'b1;
				LD_REG = 1'b1;
			end
			default : ;
		endcase
	end 

	
endmodule