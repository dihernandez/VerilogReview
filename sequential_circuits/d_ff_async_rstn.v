`timescale 1us/1ns

module tb_d_ff_async_rstn();

	logic reset_n, clk = 0, d;
	wire q, q_not;
	logic[1:0] delay;
	integer i;

	d_ff_async_rstn D_FF(
		.reset_n(reset_n), .clk(clk), .d(d),
		.q(q),.q_not(q_not));

	always begin
		#(0.5); clk = ~=clk;
	end

	initial begin
		reset_n = 0; d = 0;
		for(i = 0; i < 4; i = i + 1) begin
			delay = $urandom_range(1,3);
			#(delay) d = ~d;
		end

		reset_n = 1;
		for(i = 0; i < 4; i = i + 1) begin
			delay = $urandom_range(1,3);
			#delay d = ~d; 
		end

		d = 1'b1;
		#(0.2); reset_n = 0;
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

module d_ff_async_rstn(
	input reset_n,
	input clk,
	input d,
	output logic q,
	output q_not
	);
	always @(posedge clk or negedge reset_n) begin
		if(!reset_n) begin
			q <= 1'b0;
		end else begin
			q <= d;
		end
	end

	assign q_not = ~q;

endmodule