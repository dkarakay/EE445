module mux8(CLK,INP, OUT, SEL);

input CLK;
input [7:0] INP;
input [2:0] SEL;
output reg OUT;

wire [2:0]SEL;
wire [7:0]INP;

always @(posedge CLK or posedge INP or posedge SEL)
begin

case(SEL)
	0:OUT=INP[0];
	1:OUT=INP[1];
	2:OUT=INP[2];
	3:OUT=INP[3];
	4:OUT=INP[4];
	5:OUT=INP[5];
	6:OUT=INP[6];
	7:OUT=INP[7];
endcase
end

endmodule