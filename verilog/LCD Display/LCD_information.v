module LCD_information(
	// LCD Display Inputs and outputs
	// host side
	input 			CLOCK_50, 
	// LCD side
	output 			LCD_RS,
	output	 		LCD_E,
	output 			LCD_RW,
	inout 	[7:0] DATA_BUS,
	
	// LCD Message inputs and outputs
	input		   [1:0] SW,
	input			[4:0] raddr
	);
	
	wire DLY_RST;
	wire [4:0] disp_addr;
	wire [7:0] disp_data;
	
	Reset_Delay r0 (
      .iCLK		(CLOCK_50),
      .oRESET	(DLY_RST)
	);
	
	LCD_message lm(
		.SW		(SW),
		.raddr	(disp_addr),
		.dout		(disp_data)
	);
	
	LCD_Display u1 (
		// Host Side
		.iCLK_50MHZ	(CLOCK_50),
		.iRST_N		(DLY_RST),
		.oMSG_INDEX	(disp_addr),
		.iMSG_ASCII	(disp_data),
		// LCD Side
		.DATA_BUS	(DATA_BUS),
		.LCD_RW		(LCD_RW),
		.LCD_E		(LCD_E),
		.LCD_RS		(LCD_RS)
	);
	
endmodule