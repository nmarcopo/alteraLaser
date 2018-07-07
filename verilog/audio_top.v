module audio_top(
	// Audio Items
	input       AUD_ADCDAT,
	inout       AUD_BCLK,
	inout       AUD_ADCLRCK,
	inout       AUD_DACLRCK,
	inout       I2C_SDAT,
	output      AUD_XCK,
	output      AUD_DACDAT,
	output      I2C_SCLK,
	// End of Audio Items
	
	input wall_obstacle,
	input block_obstacle,
	input CLOCK_50
	//input reset_beep
	);
	
	/******* Audio Items *******/
	wire				   audio_out_allowed;
   wire     [31:0]   osc_out;
	
	
	// timer stuff
	reg [31:0] beepCount = 0;
	reg 		  beep_obs	= 0;
	always@ (posedge(CLOCK_50)) begin
		
		if(wall_obstacle || block_obstacle) begin
			beepCount <= 0;
			beep_obs <= 1;
		end
		else begin
			beepCount <= beepCount + 1;
		end
		
		if(beepCount > 10000000) begin
			beep_obs <= 0;
			beepCount <= 0;
		end

	end
	
	
	/******* Audio Module Initialization *******/
	square_wave_osc osc (
      .CLOCK_50						(CLOCK_50),
      .reset						   (~beep_obs),
		.wall_obstacle					(wall_obstacle),
		.block_obstacle				(block_obstacle),
      .out                       (osc_out)
   );
	
	Audio_Controller Audio_Controller (
      // Inputs
      .CLOCK_50						(CLOCK_50),
      .reset						   (~beep_obs),
      .left_channel_audio_out		(osc_out),
      .right_channel_audio_out	(osc_out),
      .write_audio_out			   (audio_out_allowed),
      .AUD_ADCDAT					   (AUD_ADCDAT),
      // Bidirectionals
      .AUD_BCLK					   (AUD_BCLK),
      .AUD_ADCLRCK				   (AUD_ADCLRCK),
      .AUD_DACLRCK				   (AUD_DACLRCK),
      // Outputs
      .audio_out_allowed			(audio_out_allowed),
      .AUD_XCK					      (AUD_XCK),
      .AUD_DACDAT					   (AUD_DACDAT)
   );
   
   avconf avc (
      .I2C_SCLK					(I2C_SCLK),
      .I2C_SDAT					(I2C_SDAT),
      .CLOCK_50					(CLOCK_50),
      .reset						(~beep_obs)
   );
endmodule