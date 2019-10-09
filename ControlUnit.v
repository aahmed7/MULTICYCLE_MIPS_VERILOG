module ControlUnit(clk,PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,PCSource,ALUOp,ALUSrcB,ALUSrcA,RegWrite,RegDst,Op,state,next_state);

	input clk;
	input [5:0] Op;
	
	output reg PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,ALUSrcA,RegWrite,RegDst;
	output reg [1:0] ALUOp,ALUSrcB,PCSource;
	
	parameter    S_0=4'b0000,
				 S_1=4'b0001,
				 S_2=4'b0010,
				 S_3=4'b0011,
				 S_4=4'b0100,
				 S_5=4'b0101,
				 S_6=4'b0110,
				 S_7=4'b0111,
				 S_8=4'b1000,
				 S_9=4'b1001,
				 S_10=4'b1010;
	
	output reg [3:0] state=4'b1010,next_state=4'b1010;
	
	always@(negedge clk)
	begin
	state=next_state;
	end
	always @( state or Op )
	begin
	PCWriteCond=1'b0;
	PCWrite=1'b0;
	IorD=1'b0;
	MemRead=1'b0;
	MemWrite=1'b0;
	MemtoReg=1'b0;
	IRWrite=1'b0;
	ALUSrcA=1'b0;
	RegWrite=1'b0;
	RegDst=1'b0;
	ALUOp=2'b00;
	ALUSrcB=2'b00;
	PCSource=2'b00;
	
	case (state)
	S_0: begin next_state=S_1;
				  MemRead=1'b1;
				  ALUSrcA=1'b0;
				  IorD=1'b0;
				  IRWrite=1;
				  ALUSrcB=2'b01;
				  ALUOp=2'b00;
				  PCWrite=1'b1;
				  PCSource=2'b00;
		  end
		  
	S_1: begin
		  ALUSrcA=1'b0;
		  ALUSrcB=2'b11;
		  ALUOp=2'b00;
		  if(Op==6'b100011) next_state=S_2;				
		  if(Op==6'b101011) next_state=S_2;
		  if(Op==6'b000000) next_state=S_6;
		  if(Op==6'b000100) next_state=S_8; 
		  if(Op==6'b000010) next_state=S_9;
						  
		  end
	
	S_2:begin
		 ALUSrcA=1'b1;
		 ALUSrcB=2'b10;
		 ALUOp=2'b00;
				 
		 if(Op==6'b100011) next_state=S_3;
		 if(Op==6'b101011) next_state=S_5;
		 
		 end
		 
	S_3:begin
	
		 MemRead=1'b1;
		 IorD=1'b1;
		 next_state=S_4;
		 
		 end
		 
	S_4:begin
		 RegDst=1'b1;
		 RegWrite=1;
		 MemtoReg=1'b0;
		 next_state=S_0;
		 end
		 
	S_5:begin
		 MemWrite=1'b1;
		 IorD=1'b1;
		 next_state=S_0;
		 end
	
	S_6:begin
		 ALUSrcA=1'b1;
		 ALUSrcB=2'b00;
		 ALUOp=2'b10;
		 next_state=S_7;
		 end
		 
	S_7:begin
		 RegDst=1'b1;
		 RegWrite=1'b1;
		 MemtoReg=1'b0;
		 next_state=S_0;
		 end
		 
	S_8:begin
		  ALUSrcA=1'b1;
		  ALUSrcB=2'b00;
		  ALUOp=2'b01;
		  PCWriteCond=1;
		  PCSource=01;
		  next_state=S_0;
		 end
		 
	S_9:begin
		 PCWrite=1'b1;
		 PCSource=2'b10;
		 next_state=S_0;
		 end
		
	S_10:begin
		 next_state=S_0;
		 end
	
	endcase
	
	end
	
endmodule
