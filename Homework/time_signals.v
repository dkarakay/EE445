module time_signals(
		input RESET, CLK, INC,
		output [15:0] TIME_SIGNAL,
		output [3:0] OUT_SQ
);

	wire clr;
	wire [3:0]  COUNT;
	assign clr = RESET; //| OUT_SIGNAL[13];
	 
	sequence_counter sc (.CLK(CLK), .RESET(RESET), .COUNT(COUNT), .INC(INC));	
	
	assign OUT_SQ = COUNT;
	
	decoder dec (.INP(COUNT), .OUT(TIME_SIGNAL));

	 
endmodule

