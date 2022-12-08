module ADD_SUB_MODULE#(
     parameter WIDTH=9)
	 (
input [WIDTH-1:0] A,B,
input add,sub,
input clk,
output reg [WIDTH-1:0] Q,
output reg AVF, E
);
wire s1;
wire[WIDTH-2:0] B_prime;
wire[WIDTH-2:0] subtraction;
wire[WIDTH-2:0] addition;
wire[WIDTH-2:0] subtraction_prime;
wire E_temp;
wire E_add;

xor xor_deci(s1,A[WIDTH-1],B[WIDTH-1]);

//Combinational addition and subtraction
assign B_prime = ~B[WIDTH-2:0];
// Add 1 with zero padding to B_prime 
assign {E_temp,subtraction} =A[WIDTH-2:0] + B_prime+ {{WIDTH-2{1'b0}}, 1'b1};
assign subtraction_prime = ~subtraction;
// Do the addition without the sign bit
assign {E_add,addition} = A[WIDTH-2:0] + B[WIDTH-2:0];

initial begin
E<=1'b0;
end

// Datapath, A is the first operand, B is the second operand and Q is the results
always @(posedge clk) begin
	if((s1 & sub)| (~s1 & add)) begin  // A + B route (same sign symbol with add or different sign symbol with subtract) 
	Q[WIDTH-2:0]<=addition;
	AVF<=E_add;
	E<=E_add;
	Q[WIDTH-1]<=A[WIDTH-1];
	end
	
	else if((s1 & add)| (~s1 & sub)) begin   // A + B' + 1 route (same sign symbol with subtract or different sign symbol with add) 
			E<=E_temp;
			AVF<=1'b0;
				if(E_temp==1'b0)begin
					Q[WIDTH-2:0]<=(subtraction_prime +{{WIDTH-2{1'b0}}, 1'b1});
					Q[WIDTH-1] <= ~ A[WIDTH-1];
				end
				
				else begin
						Q[WIDTH-2:0]<=subtraction;
						Q[WIDTH-1]<= A[WIDTH-1];
					if(subtraction == {WIDTH-1{1'b0}})
						Q[WIDTH-1]<=1'b0;

					end
				end	

end
endmodule