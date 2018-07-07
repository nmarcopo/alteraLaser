module square_wave_osc (
   input CLOCK_50,
   input reset,
	input wall_obstacle,
	input block_obstacle,
   output [31:0] out);
   
   //parameter HALF_WAVELENGTH	= 20'd56_818;     // for 440 Hz (50,000/440)/2
   parameter AMPLITUDE 	      = (32'd10_000_000 * 10);
   reg [19:0] count;
   reg phase;
   
	wire [19:0] HALF_WAVELENGTH;
		
	assign HALF_WAVELENGTH =
      wall_obstacle == 1 ? 20'd56_818 :
      block_obstacle == 1 ? 20'd31_250 :
		HALF_WAVELENGTH;
	
   always @(posedge CLOCK_50)
      if (reset) begin
         count <= 0;
         phase <= 0;
      end
      else if (count == HALF_WAVELENGTH) begin
         count <= 0;
         phase <= ~phase;
      end
      else begin
         count <= count + 1;
      end
      
   assign out = phase ? AMPLITUDE : -AMPLITUDE;

endmodule
