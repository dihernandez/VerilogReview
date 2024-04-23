`timescale 1us/1ns

module tb_tristate();

	logic a,b,sel;
	wire dout;

	mux_tristate MUXT(
		.a(a),
		.b(b),
		.sel(sel),
		.dout(dout)
		);

	initial begin
		$monitor(" a = %b, b = %b, sel = %b, dout = %b", a, b, sel, dout);
		#1; a = 0; b = 0; sel = 0;
		#1; a = 1; b = 0; sel = 0;
		#1; a = 1; b = 0; sel = 1;
		#1; a = 0; b = 1; sel = 1;
		#1; a = 0; b = 0; sel = 1;
		#1;
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end
endmodule

module mux_tristate(
	input a, b, sel,
	output dout);

	bufif0 B0 (dout,a,sel);
	bufif1 B1 (dout,b,sel);

endmodule