module Main_Memory(Data_Out,Data_In,D_addr,wr,MemRead,clk,R_addrDM,OUT_DM);

	output [31:0] Data_Out,OUT_DM;
	input clk,wr,MemRead;
	input [31:0] Data_In;
	input [4:0] D_addr,R_addrDM;
	reg [31:0] Memory [31:0];
	
	//instructions
	initial 
	begin
	Memory [0]=32'h00812020;
	Memory [1]=32'h00812020;
	Memory [2]=32'h00812022;
	Memory [3]=32'h08000000;
	end
	
	//memory operations
	assign Data_Out = MemRead ? Memory[D_addr] : 0 ;
	assign OUT_DM = Memory[R_addrDM];
	
	always @(posedge clk)
	begin
		if(wr)
		   Memory[D_addr]<=Data_In;
	end

endmodule
