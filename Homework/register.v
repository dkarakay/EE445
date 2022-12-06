module register #(parameter WIDTH=16)
    (
	  input  clk, reset, load, increment,
	  input	[WIDTH-1:0] LOAD,
	  output reg [WIDTH-1:0] OUT
    );

	 
always@(posedge clk) begin
	
	if(reset)OUT <= 0;
	else if(load) OUT<=LOAD;
	else if(increment) OUT<=OUT+1;

end
	
endmodule	 