module memory(
input CLK,WRITE_ENABLE,
input [11:0] INP_ADD,
input [15:0] INP,
output reg [15:0] OUT
);


reg [15:0] MEMORY [0:4095];
integer i = 0;

initial begin
	i=0;
	while(i<4095)begin
		MEMORY[i] = 0;
		i=i+1;
	end
end

always@(posedge CLK)
		begin
		if(WRITE_ENABLE)
			MEMORY[INP_ADD] <= INP;
		OUT <= MEMORY[INP_ADD];
		end

endmodule
