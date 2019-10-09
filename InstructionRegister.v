module IntructionRegister(Instr_in,Instr_31_26,Instr_25_21,Instr_20_16,Instr_15_0,IRWrite);

	input IRWrite;
	input [31:0] Instr_in;
	
	output reg [15:0] Instr_15_0;
	output reg [5:0] Instr_31_26;
	output reg [4:0] Instr_25_21;
	output reg [4:0] Instr_20_16;
	
	always @ ( Instr_in or IRWrite)
	begin
	if(IRWrite==1'b1)
	begin
	Instr_15_0=Instr_in[15:0];
	Instr_31_26=Instr_in[31:26];
	Instr_25_21=Instr_in[25:21];
	Instr_20_16=Instr_in[20:16];
	end
	end

endmodule
