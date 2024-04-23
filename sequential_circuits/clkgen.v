`timescale 1us/1ns

module clkgen();

	parameter HALF_PERIOD_CLK1 = 0.5;
	parameter HALF_PERIOD_CLK2 = 0.25;

	logic clk1;	// 1MHz clock, duty cycle = 50%
	logic clk2 = 0; // 2MHz clock, duty cycle = 50%
	logic clk3; // 1 MHz clock duty cycle = 30%

	initial begin
		clk1 = 0;
		forever begin
			#(HALF_PERIOD_CLK1); clk1 = ~clk1;
		end
	end

	always begin
		#(HALF_PERIOD_CLK2); clk2 = ~clk2;
	end

	initial begin
		clk3 = 1;
		forever begin
			clk3 = 1; #(0.3);
			clk3 = 0; #(0.7);
		end
	end

	initial begin
		#40 $stop;
		$display("End of clkgen"); 
	end

endmodule : clkgen