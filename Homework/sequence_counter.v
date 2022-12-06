module sequence_counter #(parameter WIDTH=4)(
  input CLK,RESET,
  input INC,
  output reg [WIDTH-1:0] COUNT
  );

always@(posedge CLK) 
begin
    if(RESET)    //Set Counter to Zero
      COUNT <= 0;
    else if(INC)
      COUNT <= COUNT + 1;
	
  end
endmodule 