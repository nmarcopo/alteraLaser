`timescale 1ns/1ns
module processor_tb ();

// wires and reg
reg			clk;
	
	reg			reset;
	
	reg			game_start;
	
	reg			right_button;
	
	reg			left_button;

	wire	[7:0]	plot_x;
	
	wire	[6:0] plot_y;
	
	wire	[2:0]	color;
	
	wire			plot;
	
	wire	[0:0]	LEDG;
	
	
	// uut
		processor uut(
		
		
			.clk				(clk),
			
			.reset			(reset),
			
			.game_start		(game_start),
			
			.right_button		(right_button),
			
			.left_button		(left_button),
		
			.plot_x			(plot_x),
			
			.plot_y			(plot_y),
			
			.color			(color),
			
			.plot				(plot)
			
		);



	always #5 clk = ~clk;
	
	initial begin
		clk = 0; game_start = 1;
		#10	left_button = 1;
		#10000 $stop;
	end

endmodule
