`timescale 1us/1ns

module tb_comparator();

	logic a,b;
	wire less_than, equal_to, greater_than;

	comparator_1bit comparator(
		.a(a),.b(b),
		.less_than(less_than),.equal_to(equal_to), 
		.greater_than(greater_than)
		);

	initial begin
		$monitor(" a = %b, b = %b, less_than = %b, equal_to = %b, greater_than = %b", a, b, less_than, equal_to, greater_than);
		#1; a = 0; b = 0;
		#1; a = 1; b = 0; 
		#1; a = 1; b = 0;
		#1; a = 0; b = 1; 
		#1; a = 1; b = 1; 
		#1; $stop;
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end
endmodule


module comparator_1bit(
	input a, b,
	output less_than, equal_to, greater_than);

	wire not_a, not_b;

	not not1(not_a, a);
	not not2(not_b, b);

	and and1(less_than, not_a, b);
	xnor xnor1(equal_to, a, b);
	and and2(greater_than, a, not_b);

endmodule