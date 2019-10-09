module ALU(Op_A,Op_B,Func,Result,zf);
	
	input [31:0] Op_A,Op_B;
	input [2:0] Func;
	output [31:0] Result;
	output zf;
	
	//wires
	reg zf;
	reg [31:0] Computed_Data;
	wire [31:0] Add_out;
	
	
	assign Result = Computed_Data;	
	Adder_Subtractor AS(Add_out,Op_A,Op_B,Func[2]);	
	
	always@(Computed_Data)
	begin
			if(Computed_Data==32'h00000000)
				zf=1'b1;
			else
				zf=1'b0;
	end
	
	always@(Op_A or Op_B or Func or Add_out)
	begin 			
			case(Func)
			3'b000:Computed_Data=Op_A&Op_B;
			3'b001:Computed_Data=Op_A|Op_B;
			3'b010:Computed_Data=Add_out;
			3'b110:Computed_Data=Add_out;
			3'b111:Computed_Data=32'h11111111
			3'b101:Computed_Data={0,(Op_A<Op_B)};
			3'b100:Computed_Data=~(Op_A|Op_B);
			endcase
	end

endmodule
