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

    SW = 16'h0003; //basic IO test1 OK!
	 #2 Run = 1;
       Continue = 1;
    #4 Run = 0;
    #4 Run = 1;
	 #4 Continue = 0;
	 #4 Continue = 1;
	 #64 SW = 16'hffff;
	 #64 SW = 16'h0000;  
    //SW = 16'h0006; //basic IO test2 OK!
    //SW = 16'h000b; //basic IO test3 OK!    
    // #96 Continue = 0; 
    // #16 Continue = 1; 
    // #96 Continue = 0; 
    // #16 Continue = 1; 
    // #96 Continue = 0; 
    // #16 Continue = 1; 
    // #96 Continue = 0; 
    // #16 Continue = 1; 
    // #96 Continue = 0; 
    // #16 Continue = 1; 
    // #96 Continue = 0; 
    // #16 Continue = 1; 

    // SW = 16'h0014; //XOR test OK!
    // #2 Run = 1;
    //    Continue = 1;
    // #4 Run = 0;
    // #4 Run = 1;
    // #4 Continue = 0;
    // #4 Continue = 1;

    // #96 SW = 16'h0f0f; //A 
    // #4 Continue = 0; 
    // #16 Continue = 1; 
    // #96 SW = 16'hf0f0; //B
    // #4 Continue = 0; 
    // #16 Continue = 1; 
    //ans should be 0x03ff (truncated the 16bits val to 10bits ) 

    // SW = 16'h0014; //run once test OK! 
    // #2 Run = 1;
    //    Continue = 1;
    // #4 Run = 0;
    // #4 Run = 1;
    // #96 Continue = 0;
    // #4 Continue = 1;
    // #96 Continue = 0; 
    // #16 Continue = 1; 
    // #96 Continue = 0; 
    // #16 Continue = 1; 
    // #96 Continue = 0; 
    // #16 Continue = 1; 
    // #96 Continue = 0; 
    // #16 Continue = 1; 
    // #96 Continue = 0; 
    // #16 Continue = 1; 
    // #96 Continue = 0; 
    // #16 Continue = 1; 


//    SW = 16'h0031; //multiplication test 
//    #2 Run = 1;
//       Continue = 1;
//    #4 Run = 0;
//    #4 Run = 1;
//    #64 Continue = 0;
//    #4 Continue = 1;
//
//    #96 SW = 10'h002; //A 
//    #4 Continue = 0; 
//    #16 Continue = 1; 
//    #96 SW = 10'h003; //B
//    #4 Continue = 0; 
//    #16 Continue = 1; 
end
endmodule