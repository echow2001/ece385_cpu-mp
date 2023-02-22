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

    
endmodule