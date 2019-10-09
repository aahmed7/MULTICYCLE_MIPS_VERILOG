module PCregister(In,Out,En,clk);

	input En,clk;
	input [31:0] In;
	
	output reg [31:0] Out=0;

	always @(negedge clk)
	begin
	if(En==1'b1) Out = In;
	end
	
endmodule
