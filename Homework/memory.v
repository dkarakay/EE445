module memory(
input CLK,WRITE_ENABLE,
input [11:0] INP_ADD,
input [15:0] INP,
output reg [15:0] OUT
);


reg [15:0] MEMORY [0:4095];
integer i = 0;

initial begin

	// Fill all memory with zeros
	i=0;
	while(i<4095)begin
		MEMORY[i] = 0;
		i=i+1;
	end
	
	MEMORY[100] = 16'h7900; //Clear AC, Address
	MEMORY[105] = 16'h7505; //Clear CMA, Address
	MEMORY[110] = 16'h7310; //Clear CME, Address
	MEMORY[115] = 16'h7215; //Clear CIR, Address
	MEMORY[120] = 16'h7200; //Clear CIL, Address
	MEMORY[125] = 16'h7165; //Clear INC, Address
	MEMORY[130] = 16'h7145; //Clear SPA, Address
	MEMORY[135] = 16'h7048; //Clear SNA, Address
	MEMORY[140] = 16'h7144; //Clear SZA, Address
	MEMORY[145] = 16'h7147; //Clear SZE, Address
	MEMORY[150] = 16'h7151; //Clear HLT, Address
	
	// Put some data to memory
	
end

always@(posedge CLK)
		begin
		// If Write Enable, write
		if(WRITE_ENABLE)
			MEMORY[INP_ADD] <= INP;
		// Else Read
		else OUT <= MEMORY[INP_ADD];
		end

endmodule
