`timescale 1ns/1ps
module testbench1();
	logic  clk, reset;
	logic  q;
	// instantiate device under test
	divideby3FSM dut(clk, reset, q);
	// generate clock
	always 
		begin
		clk = 1; #1; 
		clk = 0; #1;
		end
	// apply inputs one at a time
	initial begin
	reset = 0; #1;
	reset = 1; #1;
	reset = 0; #1;
	end
endmodule
