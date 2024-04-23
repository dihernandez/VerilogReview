`timescale 1us/1ns


module tb_gates();
	logic a, b, c, d;
	wire o1,o2,o3,o4,o5,o6,o7,o8,o9,o10;

	built_in_gates GATES1(
		.a(a),.b(b),.c(c),.d(d),
		.o1(o1),.o2(o2),.o3(o3),.o4(o4),.o5(o5),
		.o6(o6),.o7(o7),.o8(o8),.o9(o9),.o10(o10))

	initial begin
		#0.5; a = 1; b = 0; c = 1; d = 0;
		#1; a = 0; b = 1; c = 0; d = 1;
		#2; a = 0; b = 0; c = 1; d = 0;
		#1; a = 1; b = 1; c = 1; d = 1;
		#1; a = 0; b = 0; c = 0; d = 0;
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end
endmodule

module built_in_gates(
	input a,b,c,d,
	output o1,o2,o3,o4,o5,o6,o7,o8,o9,o10
	);

	and and1(o1,a,b);
	nand nand1(o2,a,b);
	or or1(o3,a,b,c,d);
	nor nor1(o4,c,d);
	xor xor1(o5,a,b,c,d);
	xnor xnor1(o6,b,d);
	buf buf1(o7,c);
	not not1(o8,d);

	buf #0.1 buf_diy(o9,c);
	and #0.2 and_diy(o10,a,b);

endmodule