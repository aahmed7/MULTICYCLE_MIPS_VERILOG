module DataPath(clk,MemWrite,MemRead,IRWrite,RegDst,RegWrite,ALUSrcA,ALUSrcB,PCSource,IorD,PC_En,MemtoReg,ALU_OP,MDR1,OutdataA,OutdataB,Out_ALUReg,Instr_31_26,R_addrDM,Addr_R,OUT_DM,OUT_R,zf,OutPCReg,Instr_31_26,Instr_25_21,Instr_20_16,Instr_15_0,ALUresult);


	input clk,MemWrite,MemRead,IRWrite,RegDst,RegWrite,ALUSrcA,IorD,PC_En,MemtoReg;
	input [1:0] ALUSrcB,PCSource,ALU_OP;
	input [4:0] R_addrDM,Addr_R;
	output zf;
	output [5:0] Instr_31_26;
	output [31:0] OUT_DM,OUT_R,MDR1,OutdataA,OutdataB,Out_ALUReg,OutPCReg,ALUresult;
	
	//wires
	wire [31:0] OutPC;
	wire [31:0] MemData,Address,Data_to_RF,ReaddataA,ReaddataB,Op_A,Op_B,JumpPC,BranchInstr,JumpInstr;
	output [4:0] Instr_25_21,Instr_20_16;
	wire [4:0] Write_Data_RF;
	output [15:0] Instr_15_0;
	wire [2:0] FuncALU;
	
	
	//branch instruction calculation
	assign BranchInstr={Instr_15_0[15],Instr_15_0[15],Instr_15_0[15],Instr_15_0[15],Instr_15_0[15],Instr_15_0[15],Instr_15_0[15],Instr_15_0[15],Instr_15_0[15],Instr_15_0[15],Instr_15_0[15],Instr_15_0[15],Instr_15_0[15],Instr_15_0[15],Instr_15_0[15],Instr_15_0[15],Instr_15_0};
	
	assign JumpInstr={BranchInstr[31:2],2'b00};
	assign JumpPC = {OutPCReg[31:28],Instr_31_26[3:0],Instr_25_21,Instr_20_16,Instr_15_0,2'b00};
	
	PCregister PC(OutPC,OutPCReg,PC_En,clk);
	
	register_state A(ReaddataA,clk,OutdataA);
	register_state B(ReaddataB,clk,OutdataB);
	register_state MDR(MemData,clk,MDR1);

	
	mux2x1_32bit MuxI(OutPCReg,Out_ALUReg,IorD,Address);
	
	Main_Memory DM(MemData,OutdataB,Address[4:0],MemWrite,MemRead,clk,R_addrDM,OUT_DM);
	IntructionRegister IR(MemData,Instr_31_26,Instr_25_21,Instr_20_16,Instr_15_0,IRWrite);
	
	mux2x1_5bit MuxR1 (Instr_20_16,Instr_15_0[15:11],RegDst,Write_Data_RF);
	mux2x1_32bit MuxR2(Out_ALUReg,MDR1,MemtoReg,Data_to_RF);
	
	REGISTER_FILE RF(Data_to_RF,clk,RegWrite,Write_Data_RF,ReaddataA,ReaddataB,Instr_25_21,Instr_20_16,Addr_R,OUT_R);
	
	mux2x1_32bit ALUSrcAMux(OutPCReg,OutdataA,ALUSrcA,Op_A);
	Mux4x1_32bit ALUSrcBMux(OutdataB,{32'd1},BranchInstr,JumpInstr,ALUSrcB,Op_B);
	
	ALU ALU1(Op_A,Op_B,FuncALU,ALUresult,zf);
	register_state ALUOut(ALUresult,clk,Out_ALUReg);
	
	mux4x1_3bit MuxPC(ALUresult,Out_ALUReg,JumpPC,0,PCSource,OutPC);
	
	ALUControl ALUCONTROL(ALU_OP,Instr_15_0[5:0],FuncALU);
	

endmodule
