module tb();
	logic [3:0] a, b;
	logic cin;
	wire[3:0] sum;
	wire cout;

	integer i,j;

	ripple_adder_4bit_structural ra(
		.a(a),
		.b(b),
		.cin(cin),
		.sum(sum),
		.cout(cout)
		);

	initial begin
		$monitor("a=%b, b=%b, cin=%0b, sum=%0d, cout=%b",a,b,cin,sum, cout);
	end

	initial begin
		#1; a = '0; b = '0; cin = 0;
		#1; a = '0; b = '0; cin = 1;
		#1; a = 4'b1; b = 4'b1; cin = 0;
		#1; a = 4'b1; b = 4'b1; cin = 1;
		#1; a = 4'd3; b = 4'd6; cin = 0;
		#1; a = {4{1'b1}}; b = {4{1'b1}}; cin = 1;

		for(i = 0; i < 2; i = i + 1) begin
			for(j = 0; j < 2; j = j + 1) begin
				#1; a = i; b = j; cin = 0;
			end
		end
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end
endmodule

module ripple_adder_4bit_structural (
	input [3:0] a, b,
	input cin,

	output [3:0] sum,
	output cout
);

	wire [2:0] c;

	full_adder_structural FAStruct1(
		.a(a[0]),
		.b(b[0]),
		.cin(cin),
		.sum(sum[0]),
		.cout(c[0])
		);

	full_adder_structural FAStruct2(
		.a(a[1]),
		.b(b[1]),
		.cin(c[0]),
		.sum(sum[1]),
		.cout(c[1])
	);

	full_adder_structural FAStruct3(
		.a(a[2]),
		.b(b[2]),
		.cin(c[1]),
		.sum(sum[2]),
		.cout(c[2])
		);

	full_adder_structural FAStruct4(
		.a(a[3]),
		.b(b[3]),
		.cin(c[2]),
		.sum(sum[3]),
		.cout(cout)
		);
endmodule : ripple_adder_4bit_structural

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