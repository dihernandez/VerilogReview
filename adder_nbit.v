`timescale 1us/1ns


module tb_adder_nbit();
	
	parameter ADDER_WIDTH = 10;
	logic [ADDER_WIDTH-1:0] a, b;
	wire [ADDER_WIDTH:0] sum;

	adder_nbit #(.N(ADDER_WIDTH))
	ADDER1 (
		.a(a),
		.b(b),
		.sum(sum)
		);

	initial begin
		$monitor($time, "a = %d, b = %d,
			sum = %d",
			a,b,sum);
		#1; a = 0; b = 0;
		#2; a = 1; b = 99;
		#1; a = 33; b = 66;
		#1; a = 100; b = 47;
		#1; $stop;
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end
endmodule

module adder_nbit #parameter(N = 3) (
	input [N-1:0] a,b,
	output logic [N:0] sum);

	always @(*) begin
		sum[N:0] = a[N-1:0] + b[N-1:0];
	end

endmodule : adder_nbit