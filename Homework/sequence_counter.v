module sequence_count #(parameter WIDTH=16)
(	input CLK, ENABLE,
	input RESET,
	output reg[WIDTH-1:0] OUT
);


always@(posedge CLK, posedge RESET)
begin
	if(RESET) 		 OUT <= 0;
	else if(ENABLE) OUT <= OUT+1;
end

endmodule