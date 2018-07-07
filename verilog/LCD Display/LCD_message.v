module LCD_message (
	input		   [1:0] SW,
	input			[4:0] raddr,
	output reg	[7:0]	dout
	);
	
   always @(raddr, SW)
		case (SW[1:0])
		
			0: begin
				case(raddr)
					0: dout = "M";
					1: dout = "o";
					2: dout = "d";
					3: dout = "e";
					4: dout = ":";
					16: dout = "E";
					17: dout = "a";
					18: dout = "s";
					19: dout = "y";
					default: dout = " ";
				endcase
			end
			
			1: begin
				case(raddr)
					0: dout = "M";
					1: dout = "o";
					2: dout = "d";
					3: dout = "e";
					4: dout = ":";
					16: dout = "M";
					17: dout = "e";
					18: dout = "d";
					19: dout = "i";
					20: dout = "u";
					21: dout = "m";
					default: dout = " ";
				endcase
			end
			
			2: begin
				case(raddr)
					0: dout = "M";
					1: dout = "o";
					2: dout = "d";
					3: dout = "e";
					4: dout = ":";
					16: dout = "H";
					17: dout = "a";
					18: dout = "r";
					19: dout = "d";
					default: dout = " ";
				endcase
			end
			
			default: begin
				case(raddr)
					0: dout = "M";
					1: dout = "o";
					2: dout = "d";
					3: dout = "e";
					4: dout = ":";
					16: dout = "E";
					17: dout = "X";
					18: dout = "T";
					19: dout = "R";
					20: dout = "E";
					21: dout = "M";
					22: dout = "E";
					default: dout = " ";
				endcase
			end
		endcase
	
endmodule
