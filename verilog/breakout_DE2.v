module breakout_DE2 (
	input				CLOCK_50,				//	50 MHz
	input	 [0:0]	KEY,
	input	 [17:0]	SW,
	
	output			VGA_CLK,   				//	VGA Clock
	output			VGA_HS,					//	VGA H_SYNC
	output			VGA_VS,					//	VGA V_SYNC
	output			VGA_BLANK,				//	VGA BLANK
	output			VGA_SYNC,				//	VGA SYNC
	output [9:0]	VGA_R,   				//	VGA Red[9:0]
	output [9:0]	VGA_G,	 				//	VGA Green[9:0]
	output [9:0]	VGA_B,	   				//	VGA Blue[9:0]
	output [17:0]	LEDR,
	
	output [2:0]	LEDG,
	
	// Audio IO
	input       AUD_ADCDAT,
	inout       AUD_BCLK,
	inout       AUD_ADCLRCK,
	inout       AUD_DACLRCK,
	inout       I2C_SDAT,
	output      AUD_XCK,
	output      AUD_DACDAT,
	output      I2C_SCLK,
	
	// Keyboard stuff
	inout			PS2_CLK,
	
	inout			PS2_DAT,
	
	
	// Score to 7 segment hex display
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2,
	
	//LCD Module 16X2
	output 				LCD_ON,		// LCD Power ON/OFF
	output 				LCD_BLON,	// LCD Back Light ON/OFF
	output 				LCD_RW,		// LCD Read/Write Select, 0 = Write, 1 = Read
	output 				LCD_EN,		// LCD Enable
	output 				LCD_RS,		// LCD Command/Data Select, 0 = Command, 1 = Data
	inout [7:0] 		LCD_DATA		// LCD Data bus 8 bits
	
	);
	assign LEDR[2:0] = SW[2:0];
	assign LEDR[17:16] = SW[17:16];
	
	wire [2:0] 	color;
	wire [7:0] 	plot_x;
	wire [6:0] 	plot_y;
	wire		  	plot;
	
	processor (
		.clk		(CLOCK_50),
		.reset	(~KEY[0]),
		.SW		(SW[2:0]),
		.MODE		(SW[17:16]),
		//.game_start	(SW[0]),
		
		//.right_button	(SW[1]),
		//.left_button	(SW[2]),
		
		.plot_x		(plot_x),
		.plot_y		(plot_y),
		.color	(color),
		.plot		(plot),
		.LEDG		(LEDG[2:0]),
	
		
		// Audio
		.AUD_ADCDAT		(AUD_ADCDAT),
		.AUD_BCLK		(AUD_BCLK),
		.AUD_ADCLRCK	(AUD_ADCLRCK),
		.AUD_DACLRCK	(AUD_DACLRCK),
		.I2C_SDAT		(I2C_SDAT),
		.AUD_XCK			(AUD_XCK),
		.AUD_DACDAT		(AUD_DACDAT),
		.I2C_SCLK		(I2C_SCLK),
		
		// Keyboard
		.PS2_CLK			(PS2_CLK),
		.PS2_DAT			(PS2_DAT),
		
		// score to seven segment hex display
		.HEX0				(HEX0),
		.HEX1				(HEX1),
		.HEX2				(HEX2),
		
		// LCD Display
		.LCD_ON			(LCD_ON),
		.LCD_BLON		(LCD_BLON),
		.LCD_RW			(LCD_RW),
		.LCD_EN			(LCD_EN),
		.LCD_RS			(LCD_RS),
		.LCD_DATA		(LCD_DATA)
		
	);
	
	vga_adapter VGA(
		.resetn(KEY[0]),
		.clock(CLOCK_50),
		.colour(color),
		.x(plot_x),
		.y(plot_y),
		.plot(plot),
		/* Signals for the DAC to drive the monitor. */
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B),
		.VGA_HS(VGA_HS),
		.VGA_VS(VGA_VS),
		.VGA_BLANK(VGA_BLANK),
		.VGA_SYNC(VGA_SYNC),
		.VGA_CLK(VGA_CLK)
	);
	defparam VGA.RESOLUTION = "160x120";
	defparam VGA.MONOCHROME = "FALSE";
	defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
	defparam VGA.BACKGROUND_IMAGE = "breakout_background.mif";
	
	
	// score stuff with RAM
	

	
	
	

endmodule
