module register_n #(parameter SIZE = 1) (
	input 						clk,
	input							en,
	input 		[SIZE-1:0]	d,
	output reg	[SIZE-1:0]	q);
	
	always @(posedge clk)
		if (en)
			q <= d;
			
endmodule
