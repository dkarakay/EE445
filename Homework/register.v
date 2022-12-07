module register #(parameter WIDTH=16)
    (
	  input  CLK, RESET, WRITE, INC,
	  input	[WIDTH-1:0] LOAD,
	  output reg [WIDTH-1:0] OUT
    );

	 
always@(posedge CLK) begin
	
	if(RESET)OUT <= 0;
	else if(WRITE) OUT<=LOAD;
	else if(INC) OUT<=OUT+1;

end
	
endmodule	 