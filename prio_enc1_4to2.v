module tb_prio_enc1_4to2();

	logic [3:0] d;
	wire v;
	wire [1:0] q;
	integer i;

	prio_enc1_4to2 PRENC(
		.d(d),
		.q(q),
		.v(v)
		);

	initial begin
		$monitor($time, " d = b%",);
	end


endmodule


module prio_enc1_4to2 (
	input [3:0] d,
	output logic [1:0] q,
	output logic v);

	always_comb begin
		if (d[3])
			q = 2'd3;
		else if (d[2])
			q = 2'd2;
		else if (d[1])
			q = 2'd1;
		else
			q = 2'd0;
	end

	always_comb begin
		if (!d)
			v = 0;
		else 
			v = 1;
	end

endmodule