module tb();
	logic a, b, cin;
	wire sum, cout;

	full_adder_behavioral fa(
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

module full_adder_behavioral (
	input a,
	input b,
	input cin,

	output logic sum,
	output logic cout
);
	
	always @(*) begin
	//	sum = a ^ b ^ cin;
	//	cout = (a & b) | (cin & (a ^ b));
      {cout, sum} = a + b + cin;
	end

endmodule