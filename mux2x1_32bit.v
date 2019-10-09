module mux2x1_32bit(In1,In2,Sel,Out);
	
	input Sel;
	input [31:0] In1,In2;
	
	output reg [31:0] Out;
	
	always @(In1 or In2 or Sel)
	begin
	case (Sel)
	1'b0:Out=In1;
	1'b1:Out=In2;
	endcase
	end


endmodule
