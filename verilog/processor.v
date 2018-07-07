module processor (
   input             clk,
   input             reset,
	input		[2:0]		SW,
	input		[1:0]		MODE,
	/*input					game_start,
	input					right_button,
	input					left_button,
	*/
   output	[7:0]		plot_x,
   output	[6:0]		plot_y,
   output	[2:0]		color,
   output            plot,
	output	[2:0]		LEDG,
		
	
	// Audio IO
	input       AUD_ADCDAT,
	inout       AUD_BCLK,
	inout       AUD_ADCLRCK,
	inout       AUD_DACLRCK,
	inout       I2C_SDAT,
	output      AUD_XCK,
	output      AUD_DACDAT,
	output      I2C_SCLK,
	
	// Keyboard IO
	inout			PS2_CLK,
	inout			PS2_DAT,
	
	// Score 7 segment hex display
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

	 
	
	wire			en_paddle_left;
	wire [1:0]	s_paddle_left;
	wire			en_paddle_right;
	wire [1:0]	s_paddle_right;
	wire			en_plot;
	wire [1:0]	s_plot;
	
	wire			write;
	
   wire        en_ball_xpos;
   wire [1:0]  s_ball_xpos;
   wire        en_ball_ypos;
   wire [1:0]  s_ball_ypos;
   wire        en_ball_xdir;
   wire        s_ball_xdir;
   wire        en_ball_ydir;
   wire        s_ball_ydir;
   wire        en_timer;
   wire        s_timer;
	wire			en_color;
   wire [1:0]  s_color;
   wire [1:0]  s_obs_xy;
   wire        ball_xdir;
   wire        ball_ydir;
   wire        timer_done;
   wire        wall_obstacle;
	wire			paddle_obstacle;
	wire			block_obstacle;
		
	// game over flag
	wire			game_over;

   controller controller (
      .clk        	  (clk        ),
      .reset      	  (reset      ),
		.game_start		  (game_start	),
		.right_button	  (right_button),
		.left_button	  (left_button),
		
		
		.en_paddle_left	(en_paddle_left),
		.s_paddle_left		(s_paddle_left),
		.en_paddle_right	(en_paddle_right),
		.s_paddle_right	(s_paddle_right),
		.en_plot				(en_plot),
		.s_plot				(s_plot),
		
      .en_ball_xpos    (en_ball_xpos    ),
      .s_ball_xpos     (s_ball_xpos     ),
      .en_ball_ypos    (en_ball_ypos    ),
      .s_ball_ypos     (s_ball_ypos     ),
      .en_ball_xdir    (en_ball_xdir    ),
      .s_ball_xdir     (s_ball_xdir     ),
      .en_ball_ydir    (en_ball_ydir    ),
      .s_ball_ydir     (s_ball_ydir     ),
      .en_timer   (en_timer   ),
      .s_timer    (s_timer    ),
		.en_score	(en_score),
		.s_score		(s_score),		
		
		.en_color	(en_color	),
      .s_color    (s_color    ),
      .s_obs_xy   (s_obs_xy   ),
      .plot       (plot       ),
		.write		(write),
		
		.LEDG			(LEDG[0]),
		
		
      .ball_xdir       (ball_xdir       ),
      .ball_ydir       (ball_ydir       ),
      .timer_done 	  (timer_done ),
      .wall_obstacle   (wall_obstacle   ),
		.paddle_obstacle (paddle_obstacle),
		.block_obstacle  (block_obstacle),
		//game over flag
		.game_over		  (game_over),
		
		.paddle_left_limit	(paddle_left_limit),
		.paddle_right_limit	(paddle_right_limit)
   );
   
   datapath datapath (
      .clk        		(clk        ),
		.write				(write),
		// new
		.en_paddle_left	(en_paddle_left),
		.s_paddle_left		(s_paddle_left),
		.en_paddle_right	(en_paddle_right),
		.s_paddle_right	(s_paddle_right),
		.en_plot				(en_plot),
		.s_plot				(s_plot),
		
      .en_ball_xpos   	(en_ball_xpos    ),
      .s_ball_xpos    	(s_ball_xpos     ),
      .en_ball_ypos   	(en_ball_ypos    ),
      .s_ball_ypos    	(s_ball_ypos     ),
      .en_ball_xdir   	(en_ball_xdir    ),
      .s_ball_xdir    	(s_ball_xdir     ),
      .en_ball_ydir   	(en_ball_ydir    ),
      .s_ball_ydir    	(s_ball_ydir     ),
      .en_timer   		(en_timer   ),
      .s_timer    		(s_timer    ),
		// score
		.en_score			(en_score),
		.s_score				(s_score),
		
		.en_color			(en_color),
      .s_color    		(s_color    ),
      .s_obs_xy   		(s_obs_xy   ),
      .ball_xdir      	(ball_xdir       ),
      .ball_ydir        (ball_ydir       ),
      .timer_done 		(timer_done ),
      .wall_obstacle   	(wall_obstacle   ),
		.paddle_obstacle	(paddle_obstacle),
		.block_obstacle	(block_obstacle),
		// game over flag
		.game_over			(game_over),
		
		.paddle_left_limit	(paddle_left_limit),
		.paddle_right_limit	(paddle_right_limit),
      .plot_x	      	(plot_x       ),
      .plot_y	    		(plot_y	     ),
      .color      		(color      ),
		.score				(score),
		.MODE					(MODE)
   );
	
	audio_top audio(
		.AUD_ADCDAT		(AUD_ADCDAT),
		.AUD_BCLK		(AUD_BCLK),
		.AUD_ADCLRCK	(AUD_ADCLRCK),
		.AUD_DACLRCK	(AUD_DACLRCK),
		.I2C_SDAT		(I2C_SDAT),
		.AUD_XCK			(AUD_XCK),
		.AUD_DACDAT		(AUD_DACDAT),
		.I2C_SCLK		(I2C_SCLK),
		
		.wall_obstacle	(wall_obstacle),
		.block_obstacle (block_obstacle),
		.CLOCK_50		(clk)
	);
	
	// Keyboard stuff
	wire	[7:0] ps2_key_data;
	wire			ps2_key_en;
	wire			keycode_ready;
	wire	[7:0] keycode;
	wire			ext;
	wire			make;
	
	// button wires
	wire			game_start;
	wire			left_button;
	wire			right_button;
	
	assign game_start = ((keycode == 8'h75 && make) || SW[0]);
	assign left_button = ((keycode == 8'h6b && make) || SW[2]);
	assign right_button = ((keycode == 8'h74 && make) || SW[1]);
	assign LEDG[1] = make;
	
	PS2_Controller PS2(
		.CLOCK_50			(clk),
		.reset				(reset),
		.PS2_CLK				(PS2_CLK),
		.PS2_DAT				(PS2_DAT),
		.received_data		(ps2_key_data),
		.received_data_en	(ps2_key_en)
	);
	
	keycode_recognizer key(
		.clk				(clk),
		.reset_n			(~reset),
		.ps2_key_en		(ps2_key_en),
		.ps2_key_data	(ps2_key_data),
		.keycode			(keycode),
		.ext				(ext),
		.make				(make),
		.keycode_ready	(keycode_ready)
	);
	
	
	
	// score for 7 segment hex display
	wire [7:0]	score;
	
	wire [3:0]conv_to_disp100;
	wire [3:0]conv_to_disp10;
	wire [3:0]conv_to_disp1;
	
	bin_to_dec conv (
	
		.binary		(score),
		
		.huns			(conv_to_disp100),
		
		.tens			(conv_to_disp10),
		
		.ones			(conv_to_disp1)
	);
	
	//display modules
	disp disp100(
		.in				(conv_to_disp100),
		//check to see if this is actually the 100's place on the board
		.out				(HEX2)
	);
	
	disp disp10(
		.in		(conv_to_disp10),
		.out		(HEX1)		
	);
	
	disp disp1(
		.in		(conv_to_disp1),
		.out		(HEX0)		
	);	
	
	
	// LCD Modules
	assign LCD_BLON = 1'b1;
	assign LCD_ON	 = 1'b1;
	LCD_information LCD(
		.CLOCK_50		(clk),
		
		.LCD_RS			(LCD_RS),
		.LCD_E			(LCD_EN),
		.LCD_RW			(LCD_RW),
		.DATA_BUS		(LCD_DATA),
				
		.SW				(MODE),
		.raddr			(raddr)
	);
	
	
endmodule
