module testbench_4bit_adder();
	logic [3:0] a, b;
	logic cin;
	wire[3:0] sum;
	wire cout;

	parameter LOOP_LIMIT = 4;
	integer i, j;

	ripple_adder_4bit_dataflow ra(
		.a(a),
		.b(b),
		.cin(cin),
		.sum(sum),
		.cout(cout)
		);

	initial begin
      $monitor("a=%d, b=%d, cin=%0b, sum=%0d, cout=%b",a,b,cin,sum, cout);
	end

	initial begin
		for(i = 0; i < LOOP_LIMIT; i = i + 1) begin
			for(j = 0; j < LOOP_LIMIT; j = j + 1) begin
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

module ripple_adder_4bit_dataflow (
	input [3:0] a, b,
	input cin,

	output [3:0] sum,
	output cout
);

	wire [2:0] c;

	full_adder_dataflow FADataflow1(
		.a(a[0]),
		.b(b[0]),
		.cin(cin),
		.sum(sum[0]),
		.cout(c[0])
		);

	full_adder_dataflow FADataflow2(
		.a(a[1]),
		.b(b[1]),
		.cin(c[0]),
		.sum(sum[1]),
		.cout(c[1])
	);

	full_adder_dataflow FADataflow3(
		.a(a[2]),
		.b(b[2]),
		.cin(c[1]),
		.sum(sum[2]),
		.cout(c[2])
		);

	full_adder_dataflow FADataflow4(
		.a(a[3]),
		.b(b[3]),
		.cin(c[2]),
		.sum(sum[3]),
		.cout(cout)
		);
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