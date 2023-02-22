// SLC3 Data path module 
// viraj shitole, ethan chow 

module datapath(input logic Clk, Reset, 
                LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED, 
                GatePC, GateMDR, GateALU, GateMARMUX, //one hot 4:1 mux
                SR2MUX, ADDR1MUX, MARMUX, BEN, MIO_EN, DRMUX, SR1MUX, //2:1 mux select signal
                MIO_EN, BEN, 
                input logic [1:0] PCMUX, ADDR2MUX, ALUK, //4:1 mux, ALU operation 
                





);

endmodule