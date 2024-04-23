module tb_encoder_8to3();
	logic [7:0] d;
	logic enable;
	wire [2:0] y;

	integer i;

	encoder_8to3 ENC3_8 (
		.d (d),
		.enable(enable),
		.y(y));

	initial begin
		$monitor($time," d = %b, y = %d", d, y);
		for(i = 0; i < 8; i = i + 1) begin
			#1; d = (1 << i); enable = 1;
		end
		#1; d = 0'b1111_1111;
	end
	
	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end

endmodule


module encoder_8to3(
	input [7:0] d,
	input enable,
	output logic [2:0] y);

	always @(*) begin
		if(enable == 0) begin
			y = 8'b0;
		end else begin
			case (d)
				8'b0000_0001 : y = 3'd0;
				8'b0000_0010 : y = 3'd1;
				8'b0000_0100 : y = 3'd2;
				8'b0000_1000 : y = 3'd3;
				8'b0001_0000 : y = 3'd4;
				8'b0010_0000 : y = 3'd5;
				8'b0100_0000 : y = 3'd6;
				8'b1000_0000 : y = 3'd7;
				default : y = 3'd0;
			endcase // d
		end
	end

endmodule