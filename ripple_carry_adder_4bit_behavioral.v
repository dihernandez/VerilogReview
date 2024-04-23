module testbench_4bit_adder_behav();
	logic [3:0] a, b;
	logic cin;
	wire[3:0] sum;
	wire cout;

	parameter LOOP_LIMIT = 4;
	integer i, j;

	ripple_adder_4bit_behavioral ra(
		.a(a),
		.b(b),
		.cin(cin),
		.sum(sum),
		.cout(cout)
		);

	initial begin
		for(i = LOOP_LIMIT; i > 0; i = i - 1) begin
			for(j = LOOP_LIMIT; j > 0; j = j - 1) begin
				a = i; b = j; cin = i%2;
				#1;
				$display($time, " a=%0d, b=%0d, cin=%0b, sum=%0d, cout=%0b", a, b, cin, sum, cout);
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

module ripple_adder_4bit_behavioral (
	input [3:0] a, b,
	input cin,

	output [3:0] sum,
	output cout
);

	wire [2:0] c;

	full_adder_behavioral FABehav1(
		.a(a[0]),
		.b(b[0]),
		.cin(cin),
		.sum(sum[0]),
		.cout(c[0])
		);

	full_adder_behavioral FABehav2(
		.a(a[1]),
		.b(b[1]),
		.cin(c[0]),
		.sum(sum[1]),
		.cout(c[1])
	);

	full_adder_behavioral FABehav3(
		.a(a[2]),
		.b(b[2]),
		.cin(c[1]),
		.sum(sum[2]),
		.cout(c[2])
		);

	full_adder_behavioral FABehav4(
		.a(a[3]),
		.b(b[3]),
		.cin(c[2]),
		.sum(sum[3]),
		.cout(cout)
		);
endmodule

module full_adder_behavioral (
	input a,
	input b,
	input cin,

	output sum,
	output cout
);

	assign {cout, sum} = a + b + cin;

endmodule