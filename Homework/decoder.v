module decoder #(parameter n=4)(
	input [n-1:0]INP,
	output reg [2**n-1:0] OUT
);

always@(*)
begin
	case(INP)
		0:  OUT <=16'h1;
		1:  OUT <=16'h2;
		2:  OUT <=16'h4;
		3:  OUT <=16'h8;
		4:  OUT <=16'h10;
		5:  OUT <=16'h20;
		6:  OUT <=16'h40;
		7:  OUT <=16'h80;
		8:  OUT <=16'h100;
		9:  OUT <=16'h200;
		10: OUT <=16'h400;
		11: OUT <=16'h800;
		12: OUT <=16'h1000;
		13: OUT <=16'h2000;
		14: OUT <=16'h4000;
		15: OUT <=16'h8000;
	endcase
end

endmodule