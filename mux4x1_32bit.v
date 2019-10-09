module Mux4x1_32bit(A,B,C,D,Sel,Out);

	input [1:0] Sel;
	input [31:0] A,B,C,D;
	
	output reg [31:0] Out;
	
	always @(A or B or C or D or Sel)
	begin
	case (Sel)
	2'b00:Out=A;
	2'b01:Out=B;
	2'b10:Out=C;
	2'b11:Out=D;
	endcase
	end

endmodule
