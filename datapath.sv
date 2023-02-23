// SLC3 Data path module 
// viraj shitole, ethan chow 
// DO NOT changed I/O names they must match the ones in cpu module 
module datapath(input logic Clk, Reset, 
                LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED, 
                GatePC, GateMDR, GateALU, GateMARMUX, //one hot 4:1 mux
                SR2MUX, ADDR1MUX, MARMUX, DRMUX, SR1MUX, //2:1 mux select signal
                BEN, MIO_EN, 
                input logic [1:0] PCMUX, ADDR2MUX, ALUK, //4:1 mux, ALU operation 
                input logic [15:0] MDR_in,
                output logic [15:0] MAR, MDR, PC, IR, 
                output logic [11:0] LED);

    logic [15:0] ALU_A, ALU_B, ALU_out;     //alu
    logic [15:0] reg_SR1_OUT, reg_SR2_OUT;  //regfile 
    logic [15:0] ADDR2_mux_out;
    logic [15:0] PC_inc, PC_branch, PC_next;//instruction pointer 
    logic [2:0] SR1, reg_DR_IN;             //regfile inputs 
    logic [2:0] cc_flag;                    //confi
    //instruction pointer logic 
    always_comb begin
        PC_inc = PC + 1; 
        PC_next = ADDR1_mux_out + ADDR2_mux_out; 
    end

    //2:1 multiplexers select 
    mux2_1 SR2_mux(.S(SR2MUX), .A_In({11{IR[4]}, IR[4:0]}), .B_In(reg_SR2_OUT), .Q_Out(ALU_B)); 
    mux2_1 ADDR1_mux(.S(ADDR1MUX), .A_In(PC), .B_In(reg_SR1_OUT), .Q_Out(ADDR1_mux_out));
    //mux2_1 MAR_mux(.S(MARMUX), .A_In(), .B_In(), .Q_Out());
    mux2_1 DR_mux #(parameter N = 3) (.S(DRMUX), .A_In(IR[11:9]), .B_In(3'b111), .Q_Out(reg_DR_IN));
    mux2_1 SR1_mux #(parameter N = 3) (.S(SR1MUX), .A_In(IR[11:9]), .B_In(IR[8:6]), .Q_Out(SR1)); //name this output better? s
    //4:1 multiplexers select 
    mux4_1 PC_mux(.S(PCMUX), .A_In(PC_inc), .B_In(bus), .C_In(PC_branch), .D_In(16'h0000), .Q_Out(PC_next));
    mux4_1 ADDR2_mux(.S(ADDR2MUX), .A_In(16'h0000), .B_In({10{IR[4]}, IR[5:0]}), .C_In({7{IR[4]}, IR[8:0]}), .D_In({5{IR[4]}, IR[10:0]}), 
                    .Q_Out(ADDR2_mux_out));

    //one hot 4:1 multiplexer for databus
    mux4_1_onehot(.S({GateALU, GateMARMUX, GateMDR, GatePC}), .A_In(PC), .B_In(MDR), .C_In(PC_next), .D_In(ALU_out), .Q_Out(bus))

    ALU(.A_in(reg_SR1_OUT), .B_In(ALU_B), .K(ALUK), .Out(ALU_out));

    //cpu register file

    //instruction register
    register IR_reg()
endmodule