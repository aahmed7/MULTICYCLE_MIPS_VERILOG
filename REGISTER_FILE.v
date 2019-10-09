module register_file(Din,clk,Wr,Addr_Wr,RegData_A,RegData_B,Addr_A,Addr_B,Addr_R,OUT_R);
	
	input clk,Wr;
	input [4:0] Addr_A,Addr_B,Addr_Wr,Addr_R;
	input [31:0] Din;
	output [31:0] RegData_A,RegData_B,OUT_R;
	reg [31:0] Reg_F [31:0];
	
	assign RegData_A = Reg_F[Addr_A];
	assign RegData_B = Reg_F[Addr_B];
	assign OUT_R = Reg_F[Addr_R];
	
	initial 
	begin
	Reg_F[0] = 32'h00000000;
	Reg_F[1] = 32'h0000000A;
	Reg_F[4] = 32'h0000000B;
	end
	
	always @(posedge clk)
	begin 
			if(Wr)
				Reg_F[Addr_Wr] <= Din;
	end
	
endmodule
