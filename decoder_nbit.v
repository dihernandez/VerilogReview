`timescale 1us/1ns

module tb_nbit_deoder();

	parameter DEC_WIDTH = 3;
	logic [DEC_WIDTH-1:0]a;
	logic enable;
	wire [2**DEC_WIDTH -1:0] y;

	integer i;

	decoder_nbit #(.N(DEC_WIDTH)) DEC1
	(
		.a(a),
		.enable(enable),
		.y(y)
		);

	initial begin
		$monitor(" a = %d, enable = %b, y%b", a, enable, y);
		#1; a = 0; enable = 0;
		for(i = 0; i < 2**DEC_WIDTH; i = i + 1) begin
			#1; a = i; enable = 1;
		end
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end
endmodule



module decoder_nbit #(N = 3)(
	input [N-1:0] a,
	input enable,
	output logic [(2**N) - 1:0] y
	);

	always @(*) begin
		if(enable == 0)
			y = 0;
		else
			y = (1 << a);
	end
endmodule