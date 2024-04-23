module easy_verilog_example();

	logic x = 1'b0;
	logic y = 1'b1;

	logic z;

	always @(z) begin
		$display("x = %b, y = %b, z = %b", x, y, z);
	end

	initial begin
		#2;
		z = x ^ y;
		#10;
		y = 0;
		z = x | y;
		#10;
		z = ~z;
		#10;
	end

endmodule