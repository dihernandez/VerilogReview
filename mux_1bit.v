`timescale 1us/1ns


module tb_mux();

	logic a,b,x;
	wire y;

	mux_1bit MUX1(
		.a(a),
		.b(b),
		.x(x),
		.y(y));

	initial begin
		#1; a = 1; b = 0; x = 1;
		#1; a = 0; b = 1; x = 0;
		#1; a = 0; b = 1; x = 1;
		#1; a = 0; b = 0; x = 1;
		#1; a = 1; b = 1; x = 1;
		#1; a = 0; b = 1; x = 0;
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end
endmodule

module mux_1bit(
	input a,b,x,
	output y);

	wire not_x;
	wire bit1;
	wire bit2;

	not not1 (not_x, x);
	and and1 (bit1, a, not_x);
	and and2 (bit2, b, x);
	or or1	(y, bit1, bit2);

endmodule