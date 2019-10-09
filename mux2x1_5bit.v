module Mux2x1_5bit(A,B,Sel,Out);

	input Sel;
	input [4:0] A,B;
	
	output reg [4:0] Out;
	
	always @(A or B or Sel)
	begin
	case (Sel)
	1'b0:Out=A;
	1'b1:Out=B;
	endcase
	end


endmodule
