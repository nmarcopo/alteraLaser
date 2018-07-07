`timescale 1ns/1ns
module datapath_tb();
	reg				 clk;
   reg             en_xpos;
   reg    [1:0]    s_xpos;
   reg             en_ypos;
   reg    [1:0]    s_ypos;
   reg             en_xdir;
   reg             s_xdir;
   reg             en_ydir;
   reg             s_ydir;
   reg             en_timer;
   reg             s_timer;
   reg             s_color;
   reg    [1:0]    s_obs_xy;
   wire            xdir;
   wire            ydir;
   wire            timer_done;
   wire            obstacle;
	wire	[7:0]		 xpos;
	wire	[6:0]		 ypos;
	wire	[2:0]		 color;

   datapath uut (
      .clk        (clk       ),
      .en_xpos    (en_xpos   ),
      .s_xpos     (s_xpos    ),
      .en_ypos    (en_ypos   ),
      .s_ypos     (s_ypos    ),
      .en_xdir    (en_xdir   ),
      .s_xdir     (s_xdir    ),
      .en_ydir    (en_ydir   ),
      .s_ydir     (s_ydir    ),
      .en_timer   (en_timer  ),
      .s_timer    (s_timer   ),
      .s_color    (s_color   ),
      .s_obs_xy   (s_obs_xy  ),
      .xdir       (xdir      ),
      .ydir       (ydir      ),
      .timer_done (timer_done),
      .obstacle   (obstacle  ),
      .xpos       (xpos      ),
      .ypos       (ypos      ),
      .color      (color     )
   );
   
   always #5 clk = ~clk;
   
   initial begin
      clk       = 0;
      en_xpos   = 1;
      s_xpos    = 0;
      en_ypos   = 1;
      s_ypos    = 0;
      en_xdir   = 1;
      s_xdir    = 0;
      en_ydir   = 1;
      s_ydir    = 0;
      en_timer  = 1;
      s_timer   = 0;
      s_color   = 1;
      s_obs_xy  = 0;
      #10 $stop;
   end
   
endmodule
