module datapath (
	input					clk,
	input					write,
	// new
	input					en_paddle_left,
	input		[1:0]		s_paddle_left,
	input					en_paddle_right,
	input		[1:0]		s_paddle_right,
	input					en_plot,
	input		[1:0]		s_plot,
	
   input             en_ball_xpos,
   input    [1:0]    s_ball_xpos,
   input             en_ball_ypos,
   input    [1:0]    s_ball_ypos,
   input             en_ball_xdir,
   input             s_ball_xdir,
   input             en_ball_ydir,
   input             s_ball_ydir,
   input             en_timer,
   input             s_timer,
	//score stuff
	input					en_score,
	input					s_score,
	
	
	// new
	input					en_color,
   input    [1:0]    s_color,
   input    [1:0]    s_obs_xy,
   output reg        ball_xdir,
   output reg        ball_ydir,
   output            timer_done,
   output            wall_obstacle,
	output				paddle_obstacle,
	output				block_obstacle,
	
	//game over flag
	output				game_over,
	
	output				paddle_left_limit,
	output				paddle_right_limit,
	output reg [7:0]	plot_x,
	output reg [6:0]	plot_y,
	output reg [2:0]	color,
	
	output reg [7:0]  score,
	
	input 	  [1:0]	MODE
   );
   
/***************************************************************************
 *                           Parameter Declarations                        *
 ***************************************************************************/
   parameter UP                = 2'd0;
   parameter DOWN              = 2'd1;
   parameter LEFT              = 2'd2;
   parameter RIGHT             = 2'd3;
 
/***************************************************************************
 *                 Internal Wire and Register Declarations                 *
 ***************************************************************************/
   reg   [25:0]   timer;
	
	
	reg	[7:0]		paddle_left;
	reg	[7:0]		paddle_right;
	reg	[7:0]		ball_xpos;
	reg	[6:0]		ball_ypos;
	
	wire	[7:0]		xobs;       // x-coordinate to obstacle memory
	wire	[6:0]		yobs;       // y-coordinate to obstacle memory
   wire  [2:0]    dout_obs;   // output of obstacle memory
	
	reg	[8:0]		initial_xball;
	

	reg 	[7:0]		score_slower;
	
	reg 	[25:0]	TIMER_LIMIT;//		 = 26'd1_000_000; // CHANGE BACK TO 26'd1_000_000
 
 
/***************************************************************************
 *                             Sequential Logic                            *
 ***************************************************************************/
	
	// Mode of game
	always @(posedge clk)
		case (MODE)
			0:	TIMER_LIMIT = 26'd1_500_000;
			1:	TIMER_LIMIT = 26'd1_000_000;
			2:	TIMER_LIMIT = 26'd750_000;
			3:	TIMER_LIMIT	= 26'd250_000;
		endcase
	
	// randomization of ball starting position
	always @(posedge clk)
		if (initial_xball < 8'd65)
				initial_xball <= initial_xball + 1;
		else
				initial_xball <= 8'd15;
		
			
		//initial_xball <= initial_xball * 2;
		
 
	// score stuff
	always @(posedge clk)
		if	(en_score) begin
			if (s_score) begin
				score_slower <= score_slower + 1;
					if (score_slower > 5) begin
						score <= score + 1;
						score_slower <= 0;
					end
			end
		else
			score <= 8'd0;
		end
	
	// new
	always @(posedge clk)
		if (en_paddle_left)
			case (s_paddle_left)
				0: paddle_left <= 8'd71;	//8'd115;
				1: paddle_left <= paddle_left - 1;
				2: paddle_left <= paddle_left + 1;
				default	:	paddle_left <= 0;
			endcase
			
	always @(posedge clk)
		if (en_paddle_right)
			case (s_paddle_right)
				0: paddle_right <= 8'd89;//	8'd133;
				1: paddle_right <= paddle_right - 1;
				2: paddle_right <= paddle_right + 1;
				default	:	paddle_right <= 0;
			endcase
			
	always @(posedge clk)
		if	(en_plot)
			case	(s_plot)
				0: begin
					plot_x <= ball_xpos;
					plot_y <= ball_ypos;
					end
				1: begin
					plot_x <= paddle_left;
					plot_y <= 7'd109;
					end
				2: begin
					plot_x <= paddle_right;
					plot_y <= 7'd109;
					end
				default :	begin
								plot_x	<= 0;
								plot_y	<= 0;
								end
			endcase
	
	
 
	always @(posedge clk)
      if (en_ball_xdir)
         if (s_ball_xdir)
            ball_xdir <= ~ball_xdir;
         else
            ball_xdir <= 1;
            
   always @(posedge clk)
      if (en_ball_ydir)
         if (s_ball_ydir)
            ball_ydir <= ~ball_ydir;
         else
            ball_ydir <= 1;
            
   always @(posedge clk)
      if (en_ball_xpos)
         case (s_ball_xpos)
				0: ball_xpos <= initial_xball * 2;
         //   0: ball_xpos <= 8'd80;
            1: ball_xpos <= ball_xpos - 1;
            2: ball_xpos <= ball_xpos + 1;
            default: ball_xpos <= 0;
         endcase       
            
   always @(posedge clk)
      if (en_ball_ypos)
         case (s_ball_ypos)
            0: ball_ypos <= 7'd30;
            1: ball_ypos <= ball_ypos - 1;
            2: ball_ypos <= ball_ypos + 1;
            default: ball_ypos <= 0;
         endcase
         
   always @(posedge clk)
      if (en_timer)
         if (s_timer)
            timer <= timer + 1;
         else
            timer <= 0;
            
				
	always @(posedge clk)
		if (en_color)
			case (s_color)
				0: color <= 3'b000;
				1: color <= 3'b010;
				2: color <= 3'b001;
				3: color <= 3'b011;
			endcase
			
 
/***************************************************************************
 *                            Combinational Logic                          *
 ***************************************************************************/

	// obstacle memory coordinate addresses
   assign xobs =
      s_obs_xy == 0 ? ball_xpos :
      s_obs_xy == 1 ? ball_xpos :
      s_obs_xy == 2 ? ball_xpos - 1 :
      ball_xpos + 1;
      
   assign yobs =
      s_obs_xy == 0 ? ball_ypos - 1 :
      s_obs_xy == 1 ? ball_ypos + 1 :
      ball_ypos;
 
   /* pixel color to VGA adapter
   assign color      = 
		s_color == 0 ? 3'b000 :
		s_color == 1 ? 3'b010 :
		s_color == 2 ?	3'b001 :
		3'b110;
   */
   // flags
   assign timer_done = (timer > TIMER_LIMIT);
   
   assign wall_obstacle   = (dout_obs == 3'b001 /*|| dout_obs == 3'b010*/);
	
	assign paddle_obstacle = (dout_obs == 3'b011);
	
	assign block_obstacle  = (dout_obs == 3'b111 || dout_obs == 3'b110 || dout_obs == 3'b100);
	
	// game over flag
	assign game_over		  = (dout_obs == 3'b010);
   
	// Outer walls are four pixels thick
	assign paddle_left_limit	= (paddle_left == 8'd5);
		
	assign paddle_right_limit	= (paddle_right == 8'd154);
	
 
 /**************************************************************************
 *                              Internal Modules                           *
 ***************************************************************************/
   image_ram obstacle_mem (
		.clk					(clk),
		.x_read				(xobs),
		.y_read				(yobs),
		.color_out			(dout_obs),
		.x_write				(plot_x),
		.y_write				(plot_y),
		.color_in			(color),
		.wren					(write)
	);
	defparam obstacle_mem.BACKGROUND_IMAGE = "breakout_background_shift.mif";
   
endmodule
