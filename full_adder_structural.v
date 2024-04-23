module tb();
	logic a, b, cin;
	wire sum, cout;

	full_adder_structural fa(
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

module full_adder_structural (
	input a,
	input b,
	input cin,

	output sum,
	output cout
);

	wire sum1;
	wire carry1;
	wire carry2;

	half_adder_structural ha1(
		.a(a),
		.b(b),
		.sum(sum1),
		.carry(carry1)
		);

	half_adder_structural ha2(
		.a(sum1),
		.b(cin),
		.sum(sum),
		.carry(carry2)
		);

	or (cout, carry1, carry2);


endmodule : full_adder_structural


module half_adder_structural (
	input a,
	input b,

	output sum,
	output carry
	);

	xor XOR1(sum,a,b);
	and AND1(carry,a,b);
endmodule