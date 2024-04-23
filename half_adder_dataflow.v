module testbench();
	logic a;
	logic b;
	wire sum;
	wire carry;

	half_adder_dataflow half_adder_df(
		.a(a),
		.b(b),
		.sum(sum),
		.carry(carry)
		);

	initial begin
		$monitor("a=%b, b=%b, sum=%b, carry=%b",a,b,sum,carry);
	end

	initial begin
		#1; a = 0; b = 0;
		#1; a = 0; b = 1;
		#1; a = 1; b = 0;
		#1; a = 1; b = 1;
		#1; a = 0; b = 0;
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end

endmodule

module half_adder_dataflow(
	input a,
	input b,
	output sum,
	output carry
	);
	
	assign sum = a ^ b;
	assign carry = a & b;
endmodule