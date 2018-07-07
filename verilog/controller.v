module controller (
	input 				   clk,
	input 				   reset,
	input						game_start,
	input						right_button,
	// new
	input						left_button,
	
	output reg				en_paddle_left,
	output reg	  [1:0]	s_paddle_left,
	output reg				en_paddle_right,
	output reg	  [1:0]	s_paddle_right,
	output reg				en_plot,
	output reg	  [1:0]	s_plot,
	
	
   output reg           en_ball_xpos,
   output reg    [1:0]  s_ball_xpos,
   output reg           en_ball_ypos,
   output reg    [1:0]  s_ball_ypos,
   output reg           en_ball_xdir,
   output reg           s_ball_xdir,
   output reg           en_ball_ydir,
   output reg           s_ball_ydir,
   output reg           en_timer,
   output reg           s_timer,
	
	// score stuff
	output reg				en_score,
	output reg				s_score,
	
	
	output reg				en_color,
   output reg    [1:0]  s_color,
   output reg    [1:0]  s_obs_xy,
   output reg           plot,
	output reg				write,
	
	output reg	  [0:0]	LEDG,
	
   input                ball_xdir,
   input                ball_ydir,
   input                timer_done,
   input                wall_obstacle,
	input						paddle_obstacle,
	input						block_obstacle,
	
	// game over flag
	input						game_over,
	
	input						paddle_left_limit,
	input						paddle_right_limit
	);
   
   parameter UP                = 2'd0;
   parameter DOWN              = 2'd1;
   parameter LEFT              = 2'd2;
   parameter RIGHT             = 2'd3;
   
   parameter INIT              		= 5'd0;
   parameter WAIT_TIMER        		= 5'd1;
	parameter ERASE_LEFT_SIDE			= 5'd2;
	// buffer state
	parameter BUFFER_ELS					= 5'd3;
	parameter MOVE_PADDLE_RIGHT		= 5'd4;
	parameter DRAW_RIGHT_SIDE			= 5'd5;
	// buffer
	parameter BUFFER_DRS					= 5'd6;
	 
	parameter ERASE_RIGHT_SIDE			= 5'd7;
	// buffer
	parameter BUFFER_ERS					= 5'd8;
	parameter MOVE_PADDLE_LEFT			= 5'd9;
	parameter DRAW_LEFT_SIDE			= 5'd10;
	// buffer
	parameter BUFFER_DLS					= 5'd11;
	// end of new states
   parameter ERASE_BALL         		= 5'd12;
	// buffer
	parameter BUFFER_EB					= 5'd13;
   parameter LOOK_LEFT         		= 5'd14;
   parameter LOOK_RIGHT        		= 5'd15;
   parameter TEST_X_OBSTACLE   		= 5'd16;
   parameter CHANGE_BALL_XDIR       = 5'd17;
   parameter LOOK_UP           		= 5'd18;
   parameter LOOK_DOWN         		= 5'd19;
   parameter TEST_Y_OBSTACLE   		= 5'd20;
	// score stuff
	parameter SCORE_POINT				= 5'd21;
	
   parameter CHANGE_BALL_YDIR       = 5'd22;
   parameter DECREMENT_XPOS    		= 5'd23;
   parameter INCREMENT_XPOS    		= 5'd24;
   parameter DECREMENT_YPOS    		= 5'd25;
   parameter INCREMENT_YPOS    		= 5'd26;
   parameter DRAW_BALL              = 5'd27;
	// buffer
	parameter BUFFER_DB					= 5'd28;
	
	// game over state
	parameter GAME_OVER					= 5'd29;
   
   reg [4:0] state, next_state;
   
   always @(posedge clk)
      if (reset)
         state <= INIT;
      else
         state <= next_state;
         
   always @(*) begin
		// new
		en_paddle_left 		= 0;
		s_paddle_left 			= 0;
		en_paddle_right		= 0;
		s_paddle_right 		= 0;
		en_plot					= 0;
		s_plot					= 0;
		
      en_ball_xpos  			= 0;
      s_ball_xpos   			= 0;  
      en_ball_ypos  			= 0;
      s_ball_ypos   			= 0;
      en_ball_xdir  			= 0;  
      s_ball_xdir   			= 0;
      en_ball_ydir  			= 0;
      s_ball_ydir   			= 0;  
      en_timer					= 0; 			 
      s_timer 					= 0; 
      s_color 					= 0;
      s_obs_xy					= 0;
      plot    					= 0;
		write 					= 0;
		LEDG[0]					= 0;
		
		// score
		en_score					= 0;
		s_score					= 0;
		
      next_state = INIT;
      case (state)
         INIT              : begin
			// new
				s_paddle_left 	= 0;  en_paddle_left 	= 1;
				s_paddle_right = 0;	en_paddle_right 	= 1;
				s_score 		= 0;	en_score		 = 1;
            s_ball_xdir = 0;  en_ball_xdir = 1;
            s_ball_ydir = 0;  en_ball_ydir = 1;
            s_ball_xpos = 0;  en_ball_xpos = 1;
            s_ball_ypos = 0;  en_ball_ypos = 1;
            s_timer = 0; en_timer = 1;
            
				if	(game_start)
				next_state = WAIT_TIMER;
				else
				next_state = INIT;
         end
         WAIT_TIMER        : begin
            //s_color = 1; en_color = 1;
            //plot = 1;	write = 1;
            s_timer = 1; en_timer = 1;
            if (timer_done)   
					if (right_button)		begin
						
						if (paddle_right_limit)
							next_state = ERASE_BALL;
						else
							next_state = ERASE_LEFT_SIDE;
						end
					else if (left_button) 	begin
						
						if (paddle_left_limit)
							next_state = ERASE_BALL;
						else
							next_state = ERASE_RIGHT_SIDE;
						end
					else			begin			next_state = ERASE_BALL; end
            else     			      	next_state = WAIT_TIMER;
         end
			
			ERASE_LEFT_SIDE	: begin
				s_timer = 0; en_timer = 1;
				
				// new
				s_plot = 1;	en_plot = 1;
				plot = 0;	write = 1;	
				s_color = 0; en_color = 1;// color
				
				next_state = BUFFER_ELS;
			end
			
			BUFFER_ELS			: begin
				plot = 1; write = 1;
				s_plot = 1;	en_plot = 1;
				s_color = 0; en_color = 1;
				next_state = MOVE_PADDLE_RIGHT;
				
			end
			
			
			MOVE_PADDLE_RIGHT	: begin
				
			
								
				// new
				s_paddle_left = 2; en_paddle_left = 1;
				s_paddle_right = 2;	en_paddle_right = 1;
				
				next_state = DRAW_RIGHT_SIDE;
				
			end
			
			DRAW_RIGHT_SIDE	: begin
				// new
				plot = 0;	write = 1;	
				s_color = 3; en_color = 1;// color
				s_plot = 2;	en_plot = 1;
				
				next_state = BUFFER_DRS;
			end	
			
			BUFFER_DRS			: begin
				plot = 1; write = 1; 
				s_plot = 2;	en_plot = 1;
				s_color = 3; en_color = 1;
				next_state = ERASE_BALL;
			end
			
			ERASE_RIGHT_SIDE	: begin
				s_timer = 0; en_timer = 1;
				
				// new
				s_plot = 2;	en_plot = 1;
				plot = 0;	write = 1;	
				s_color = 0; en_color = 1;// color
				
				next_state = BUFFER_ERS;
			end
			
			BUFFER_ERS			: begin
				plot = 1; write = 1;
				s_plot = 2;	en_plot = 1;
				next_state = MOVE_PADDLE_LEFT;
				s_color = 0; en_color = 1;
			end
			
			MOVE_PADDLE_LEFT	: begin
				
				// new
				s_paddle_left = 1; en_paddle_left = 1;
				s_paddle_right = 1;	en_paddle_right = 1;
				
				next_state = DRAW_LEFT_SIDE;
				
			end
			
			DRAW_LEFT_SIDE	: begin
				// new
				plot = 0;	write = 1;	
				s_color = 3; en_color = 1;// color
				s_plot = 1;	en_plot =1;
				
				next_state = BUFFER_DLS;
			end	
			
			BUFFER_DLS		: begin
				plot = 1; write = 1;
				s_plot = 1;	en_plot =1;
				s_color = 3; en_color = 1;
				next_state = ERASE_BALL;
			end
			
			
         ERASE_BALL             : begin
            plot = 0;  write = 1;  
				s_color = 0;	en_color = 1;
            s_timer = 0; en_timer = 1;
				// new
				s_plot = 0;	en_plot = 1;
				
				next_state = BUFFER_EB;
            
         end
			
			BUFFER_EB				: begin
				plot = 1; write = 1;
			
				if (ball_xdir)         next_state = LOOK_RIGHT;
            else              	  next_state = LOOK_LEFT;
			end
			
         LOOK_LEFT         : begin
            s_obs_xy = LEFT;
            next_state = TEST_X_OBSTACLE;
         end
         LOOK_RIGHT        : begin
            s_obs_xy = RIGHT;
            next_state = TEST_X_OBSTACLE;
         end
         TEST_X_OBSTACLE   : begin
            if (wall_obstacle || paddle_obstacle)     next_state = CHANGE_BALL_XDIR;
				else if (block_obstacle)		next_state = SCORE_POINT;
            else if (ball_ydir)    next_state = LOOK_DOWN;
            else              next_state = LOOK_UP;
         end
         CHANGE_BALL_XDIR       : begin
            s_ball_xdir = 1; en_ball_xdir = 1;
            if (ball_ydir)         next_state = LOOK_DOWN;
            else              next_state = LOOK_UP;
         end
         LOOK_UP           : begin
            s_obs_xy = UP;
            next_state = TEST_Y_OBSTACLE;
         end
         LOOK_DOWN         : begin
            s_obs_xy = DOWN;
            next_state = TEST_Y_OBSTACLE;
         end
         TEST_Y_OBSTACLE   : begin
            if (wall_obstacle || paddle_obstacle)     next_state = CHANGE_BALL_YDIR;
				//else if (block_obstacle)		next_state = SCORE_POINT;
				
				// game over transition!!
				else if (game_over)	  next_state = GAME_OVER;
				
            else if (ball_xdir)    next_state = INCREMENT_XPOS;
            else              next_state = DECREMENT_XPOS;
         end
			
			SCORE_POINT			: begin
					s_score = 1;	en_score = 1;
					
					if (ball_xdir)    next_state = INCREMENT_XPOS;
					else					next_state = DECREMENT_XPOS;
			end
					
			
         CHANGE_BALL_YDIR       : begin
            s_ball_ydir = 1; en_ball_ydir = 1;
            if (ball_xdir)         next_state = INCREMENT_XPOS;
            else              next_state = DECREMENT_XPOS;      
         end
         DECREMENT_XPOS    : begin
            s_ball_xpos = 1; en_ball_xpos = 1;
            if (ball_ydir)         next_state = INCREMENT_YPOS;
            else              next_state = DECREMENT_YPOS;
         end
         INCREMENT_XPOS    : begin
            s_ball_xpos = 2; en_ball_xpos = 1;
            if (ball_ydir)         next_state = INCREMENT_YPOS;
            else              next_state = DECREMENT_YPOS;
         end
         DECREMENT_YPOS    : begin
            s_ball_ypos = 1; en_ball_ypos = 1;
            next_state = DRAW_BALL;
         end
         INCREMENT_YPOS    : begin
            s_ball_ypos = 2; en_ball_ypos = 1;
            next_state = DRAW_BALL;
         end
         DRAW_BALL              : begin
            s_color = 1; en_color = 1;
				plot = 0;	write = 1;
				s_plot = 0;	en_plot = 1;
				
            next_state = BUFFER_DB;
         end
			
			
			BUFFER_DB				: begin
				plot = 1; write = 1;
				
				next_state = WAIT_TIMER;
				
			end
			
			GAME_OVER				: begin
				
			
				
				LEDG[0] = 1;
				next_state = GAME_OVER;
			end
			
         default           :;
      endcase
   end

   
endmodule
