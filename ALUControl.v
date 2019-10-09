module ALUControl(ALU_OP,Func,ALU_Result);

	input [1:0] ALU_OP;	
	input [5:0]Func;
	
	output reg [2:0] ALU_Result;
	reg [2:0] Result;
	 
	always @(ALU_OP or Func)
	begin
	
	case(Func)
	6'b100000:Result=3'b010;
	6'b100010:Result=3'b110;
	6'b100100:Result=3'b000;
	6'b100101:Result=3'b001;
	6'b101010:Result=3'b111;
	endcase
	
	case(ALU_OP)
	2'b00: ALU_Result=3'b010;
	2'b01: ALU_Result=3'b110;
	2'b10: ALU_Result=Result;
	endcase
	end

endmodule
