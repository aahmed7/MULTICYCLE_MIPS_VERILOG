module Processor(clk,R_addrDM,Addr_R,MDR1,OutdataA,OutdataB,OutALUOut,OUT_DM,OUT_R,state,next_state,OutPCReg,Instr_31_26,Instr_25_21,Instr_20_16,Instr_15_0,MemWrite,MemRead,IRWrite,RegDst,RegWrite,ALUSrcA,IorD,PC_En,MemtoReg,PCWrite,PCWriteCond,ALUSrcB,PCSource,ALUOp,ALUresult);
	
	input clk;
	input [4:0] R_addrDM,Addr_R;
	output [31:0] MDR1,OutdataA,OutdataB,OutALUOut,OUT_DM,OUT_R,ALUresult;
	output [3:0] state,next_state,OutPCReg;
	output [5:0] Instr_31_26;
	output [4:0] Instr_25_21,Instr_20_16;
	output [15:0] Instr_15_0;
	output [1:0] ALUSrcB,PCSource,ALUOp;
	output MemWrite,MemRead,IRWrite,RegDst,RegWrite,ALUSrcA,IorD,MemtoReg,PCWrite,PCWriteCond;
	wire [5:0] Instr_31_26;
	wire aout,zf;
	wire PC_En1;
	output reg PC_En=0;
	
	
	DataPath D1(clk,MemWrite,MemRead,IRWrite,RegDst,RegWrite,ALUSrcA,ALUSrcB,PCSource,IorD,PC_En,MemtoReg,ALUOp,MDR1,OutdataA,OutdataB,OutALUOut,Instr_31_26,R_addrDM,Addr_R,OUT_DM,OUT_R,zf,OutPCReg,Instr_31_26,Instr_25_21,Instr_20_16,Instr_15_0,ALUresult);
	
	ControlUnit C1(clk,PCWriteCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,PCSource,ALUOp,ALUSrcB,ALUSrcA,RegWrite,RegDst,Instr_31_26,state,next_state);
	
	and a1(aout,zf,PCWriteCond);
	or  o1(PC_En1,PCWrite,aout);
	
	always @(PC_En1)
	begin
	PC_En=PC_En1;
	end
	 
endmodule
