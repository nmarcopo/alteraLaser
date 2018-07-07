module image_ram (
	clk,
	x_read,
	y_read,
	color_out,
	x_write,
	y_write,
	color_in,
	wren);

	// parameters
	parameter RESOLUTION 					= "160x120";
	parameter BITS_PER_COLOUR_CHANNEL 	= 1;
	parameter MONOCHROME 					= "FALSE";
	parameter BACKGROUND_IMAGE 			= "test.mif";
	
	// declare inputs and outputs
	input 			clk;
	input 	[7:0]	x_read;
	input 	[6:0]	y_read;
	output 	[2:0]	color_out;
	input 	[7:0]	x_write;
	input 	[6:0]	y_write;
	input 	[2:0]	color_in;
	input				wren;
	
	// internal wires
	wire [14:0] raddr;
	wire [14:0] waddr;
	
	// module instances
	vga_address_translator read_translator (
		.x(x_read), 
		.y(y_read), 
		.mem_address(raddr) 
	);
	defparam read_translator.RESOLUTION = RESOLUTION;
	
	vga_address_translator write_translator (
		.x(x_write), 
		.y(y_write), 
		.mem_address(waddr) 
	);
	defparam write_translator.RESOLUTION = RESOLUTION;

	
	lpm_ram_dq ImageMemory (
		.data			(color_in),
		.address		(wren ? waddr : raddr),
		.inclock		(clk),
//		.outclock	(clk),
		.we			(wren),
		.q				(color_out)
	);
	defparam ImageMemory.lpm_width		= 3;
	defparam ImageMemory.lpm_widthad		= 15;
	defparam ImageMemory.lpm_numwords	= 19200;
	defparam ImageMemory.lpm_outdata		= "UNREGISTERED";
	defparam ImageMemory.lpm_file			= BACKGROUND_IMAGE;
	
endmodule
