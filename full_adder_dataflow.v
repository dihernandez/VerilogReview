module tb();
	logic a, b, cin;
	wire sum, cout;

	full_adder_dataflow fa(
		.a(a),
		.b(b),
		.cin(cin),
		.sum(sum),
		.cout(cout)
		);

	initial begin
		$monitor("a=%b, b=%b, cin=%0b, sum=%b, cout=%b",a,b,cin,sum, cout);
	end

	initial begin
		#1; a = 0; b = 0; cin = 0;
		#1; a = 0; b = 0; cin = 1;
		#1; a = 0; b = 1; cin = 0;
		#1; a = 0; b = 1; cin = 1;
		#1; a = 1; b = 0; cin = 0;
		#1; a = 1; b = 0; cin = 1;
		#1; a = 1; b = 1; cin = 0;
		#1; a = 1; b = 1; cin = 1;
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end
endmodule

module full_adder_dataflow (
	input a,
	input b,
	input cin,

	output sum,
	output cout
);

	wire sum1;
	wire and1;
	wire and2;

	assign sum1 = a ^ b;
	assign and1 = sum1 & cin;
	assign and2 = a & b;

	assign sum = sum1 ^ cin;
	assign cout = and1 | and2;

endmodule