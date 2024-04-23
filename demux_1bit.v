`timescale 1us/1ns


module tb_demux();

	logic x, sel;
	wire y0,y1;

	demux_1bit DEMUX1(
		.x(x),
		.sel(sel),
		.y0(y0),
		.y1(y1));

	initial begin
		#1; x = 1;
		#1; x = 0;
		#2; x = 1;
		#1.5; x = 0;
		#0.5; x = 1;
		#2;
	end

	initial begin
		#1; sel = 0;
		#1; sel = 1;
		#2; sel = 1;
		#1.0; sel = 0;
		#1; sel = 1;
		#1; sel = 0;
		#5;
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#200;
		$finish();
	end
endmodule

module demux_1bit(
	input x, sel,
	output y0, y1);

	wire sel_not;

	not no1 (sel_not, sel);
	and and1 (y0, x, sel_not);
	and and2 (y1, x, sel);
endmodule