`timescale 1us/1ns

module tb_tristate();

	logic din, sel;
	wire dout;

	tristate_buffer_1bit TRI1(
		.din(din),
		.sel(sel),
		.dout(dout)
		);

	initial begin
		$monitor(" din = %b, sel = %b, dout = %b",din, sel, dout);
		#1; din = 0; sel = 0;
		#1; din = 1; sel = 0;
		#1; din = 0; sel = 1;
		#1; din = 1; sel = 0;
		#1; din = 1; sel = 1;
		#2; din = 0;
		#5; $stop;
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end
endmodule

module tristate_buffer_1bit(
	input din,
	input sel,
	output dout);
	bufif1 B1(dout, din, sel);
endmodule