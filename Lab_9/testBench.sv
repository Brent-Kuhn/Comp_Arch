`timescale 1ns/1ps
module aluTestBench();
	// Initialize variable logic
	logic [31:0]a;
	logic [31:0]b;
	logic [31:0]y;
	logic [2:0]f;
	logic zero;
	logic [31:0]yExpect;
	logic zExpect;
	logic clk;
	// Make a register to save the input vectors
	reg [100:0] testVector [20:0];
	// Counter for selecting test vectors
	int i;
	// Import the alu module
	alu dut(a, b, f, y, zero);
	// Initialize the clock
	initial begin 
		i = 0;
		$display("Loading the file");
		// Read from memory in binary format
		$readmemb("testVectors.txt", testVector);
		forever begin
			// Set to 1
			clk = 1;
			// Wait 1 nanosecond
			#1;
			// Set to zero
			clk = 0;
			// WAIT AGAIN
			#1;
		end
	end
	// Load the stuff in at the postitive edge of the clock
	always @(posedge clk)
	begin
		{f, a, b, yExpect, zExpect} = testVector[i];
	end
	
	always @(negedge clk)
	begin
		i = i + 1;
		if(yExpect != y || zExpect != zero)
		begin
			$display("Incorrect output for %d", i);
		end
	end
endmodule

		

	
	