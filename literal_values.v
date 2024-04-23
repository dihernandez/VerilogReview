module literal_values();

	logic [7:0] my_var;

	initial begin
		my_var = 8'd137;
		$display("my_var = %d",my_var);

		my_var = 8'h89;
		$display("my_var = %x",my_var);

		my_var = 8'b1000_1001;
		$display("my_var = %b",my_var);

		my_var = 8'hz1;
		$display("my_var = %b",my_var);

		my_var = 1'b1;
		$display("my_var = %b",my_var);

		my_var = 12'b1111_1111_0000;
		$display("my_var = %b",my_var);
	end

endmodule