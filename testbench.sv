module testbench_cp1();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.

logic [9:0] SW; 
logic Clk, Run, Continue; // the reset is result of continue & run. 
logic [9:0] LED; 
//logic CE, UB, LB, OE, WE; no need to break out signal in tb
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
// Instantiating the DUT
// Make sure the module and signal names match with those in your design
slc3_testtop toplevel0(.*);	

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS
    //Reset = 0;
    Run = 0; 
    Continue = 0; 
    SW = 16'h0003;
    //#2 Reset = 1;
    #2 Run = 1;
    Continue = 1;
    #4 Run = 0;
    #4 Run = 1;
    #4 Continue = 0;
    #4 Continue = 1;
    #256 Continue = 0; 
    #4 Continue = 1; 
end
endmodule