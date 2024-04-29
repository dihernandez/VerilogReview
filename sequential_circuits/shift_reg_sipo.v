`timescale 1us/1ns

module tb_shift_reg_sipo();

	reg sdi;
	reg clk = 0;
	reg reset_n;
	wire [3:0] q;

	shift_reg_sipo SIPO0(
		.reset_n(reset_n),
		.clk(clk),
		.sdi(sdi),
		.q(q));

	always begin
		#0.5 clk = ~clk;
	end

	initial begin
		#1;
		reset_n = 0; sdi = 0;
		#1.3;
		reset_n = 1;
		repeat(2) @(posedge clk);

        @(posedge clk); sdi = 1'b1; @(posedge clk); sdi = 1'b0;

		repeat(4) @(posedge clk);
		@(posedge clk); sdi = 1'b1;
		repeat(2) @(posedge clk); sdi = 1'b0;

		repeat(3) @(posedge clk); sdi = 1'b1;
		@(posedge clk); sdi = 1'b0; 
		@(posedge clk); sdi = 1'b1; 
		@(posedge clk); sdi = 1'b0; 
	end

	initial begin
		#40 $finish;
	end

	
	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end

endmodule

module shift_reg_sipo(
	input reset_n,
	input clk,
	input sdi,
	output reg [3:0] q
	);

	always @(posedge clk or negedge reset_n) begin
		if(!reset_n) 
			q <= 4'b0;
		else
			q[3:0] <= {q[2:0], sdi};
	end

endmodule