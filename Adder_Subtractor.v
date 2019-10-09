module Adder_Subtractor(Result,A,B,add_Sub);
	
	input add_Sub;
	input [31:0] A,B;
	
	output [31:0] Result;
	reg Result;
	
	wire [31:0] In_int;
	
	//if add_sub = 1, take 2's complement of B
	assign In_int = B^{add_Sub,add_Sub,add_Sub,add_Sub,add_Sub,add_Sub,add_Sub,add_Sub,
								 add_Sub,add_Sub,add_Sub,add_Sub,add_Sub,add_Sub,add_Sub,add_Sub,
								 add_Sub,add_Sub,add_Sub,add_Sub,add_Sub,add_Sub,add_Sub,add_Sub,
								 add_Sub,add_Sub,add_Sub,add_Sub,add_Sub,add_Sub,add_Sub,add_Sub};
								 
	always @(A or B or In_int or add_Sub)
	begin
			Result = A + In_int + add_Sub ;
	end

endmodule
