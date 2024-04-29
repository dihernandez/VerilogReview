`timescale 1us/1ns

module tb_shift_reg_piso();

	reg sdi;
	reg [3:0] d;
	reg preload;
	reg clk = 0;
	reg reset_n;
	wire sdo;

	shift_reg_piso PISO0(
		.reset_n(reset_n),
		.clk(clk),
		.sdi(sdi),
		.pl(preload),
		.d(d),
		.sdo(sdo));

	always begin
		#0.5 clk = ~clk;
	end

	initial begin
		#1;
		reset_n = 0; sdi = 0; preload = 0; d = 0;
		#1.3;
		reset_n = 1;

        @(posedge clk); d = 4'b0101; preload = 1; @(posedge clk); preload = 0;

		repeat(5) @(posedge clk);
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


module shift_reg_piso(
	input reset_n,
	input clk,
	input sdi,
	input pl,
	input [3:0] d,
	output sdo
	);
	
	reg [3:0] piso;
	wire [3:0] data_src;

	assign data_src = pl ? d : {piso[2:0], sdi};

	always @(posedge clk or negedge  reset_n) begin
		if (!reset_n)
			piso <= 4'b0;
		else
			piso[3:0] <= data_src;
	end

	assign sdo = piso[3];

endmodule