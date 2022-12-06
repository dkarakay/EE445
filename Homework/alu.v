module ALU #(parameter WIDTH=5)

(	input CLK,
	input  [WIDTH-1:0] AC,DR,
	input  E,
	input  [3:0] SEL, 
	output [WIDTH-1:0] OUT,
	output OVF, CO, Z, N
);

reg fZ, fCO, fOVF, fN;
reg [WIDTH:0] data;

always@(posedge CLK)begin
	case(SEL)
	
	4'b0000 : data <= AC + DR;          	  // ADD
	4'b0001 : data <= AC & DR;					  // AND
	4'b0010 : data <= DR;						  // LOAD
	4'b0011 : data <= ~AC;						  // COMPLEMENT
	4'b0100 : data <= {{E},{AC[WIDTH-1:1]}}; // SHIFT RIGHT
	4'b0101 : data <= {{AC[WIDTH-2:0]},{E}}; // SHIFT LEFT
endcase
	
	
	if(data == 0) fZ <= 1;
	else   		  fZ <= 0;
	
	if(data >= 0) fN <= 0;
	else   		  fN <= 1;
	
	if(SEL == 0)begin
		if(data[WIDTH] == 1) fCO <= 1;
		else   		  			fCO <= 0;
		
		if(data[WIDTH-1] == 1 && AC[WIDTH-1]==0 && DR[WIDTH-1]==0) 
									  fOVF <= 1;
									  fOVF <= 0;
		if(data[WIDTH-1] == 0 && AC[WIDTH-1]==1 && DR[WIDTH-1]==1)
									  fOVF <= 1;
		else   		  			  fOVF <= 0;
	end
	else begin 
		fOVF <= 0;
		fCO <= 0;
	end
end

assign Z = fZ;
assign N = fN;
assign CO = fCO;
assign OVF = fOVF;
assign OUT = data[WIDTH-1:0];


endmodule