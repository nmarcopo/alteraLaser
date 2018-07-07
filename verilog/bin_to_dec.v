module bin_to_dec (
	input [7:0] binary,
	output reg [3:0] huns,
	output reg [3:0] tens,
	output reg [3:0] ones
	);

	// Concept of decimal to BCD converter taken from: 
	// http://www.eng.utah.edu/~nmcdonal/Tutorials/BCDTutorial/BCDConversion.html
	
	integer count;
	
	always @(binary)	
		begin
			// zero out each binary representation of the decimals	
			huns = 4'd0;
			tens = 4'd0;
			ones = 4'd0;
			
		for ( count = 7; count >=0; count = count-1)
			begin	// first always check to see if three needs to be added to any of the columns
				if (huns >= 5)
					huns = huns + 3;
				if (tens >= 5)
					tens = tens + 3;
				if (ones >= 5)
					ones = ones + 3;

				// now shift everything to the left
				huns = huns << 1;
				huns[0] = tens[3];
				tens = tens << 1;
				tens[0] = ones[3];
				ones = ones << 1;
				ones[0] = binary[count];
			end
		end
endmodule