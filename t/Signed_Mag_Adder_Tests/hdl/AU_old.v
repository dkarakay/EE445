module ADD_SUB_MODULE(
input [31:0] A,B,
input add,sub,
input clk,
output reg [31:0] Q,
output reg AVF, E
);
wire s1;
wire[30:0] B_prime;
wire[30:0] subtraction;
wire[30:0] addition;
wire[30:0] subtraction_prime;
wire E_temp;
wire E_add;

xor xor_deci(s1,A[31],B[31]);

//Combinational addition and subtraction
assign B_prime = ~B[30:0];
assign {E_temp,subtraction} =A[30:0] + B_prime+ 31'h1;
assign subtraction_prime = ~subtraction;
assign {E_add,addition} = A[30:0] + B[30:0];

initial begin
E<=1'b0;
end

// Datapath, A is the first operand, B is the second operand and Q is the results
always @(posedge clk) begin
	if((s1 & sub)| (~s1 & add)) begin  // A + B route
	Q[30:0]<=addition;
	AVF<=E_add;
	E<=E_add;
	Q[31]<=A[31];
	end
	
	else if((s1 & add)| (~s1 & sub)) begin   // A + B' + 1 route
			E<=E_temp;
			AVF<=1'b0;
				if(E_temp==1'b0)begin
					Q[30:0]<=(subtraction_prime +31'h1);
					Q[31] <= ~ A[31];
				end
				
				else begin
						Q[30:0]<=subtraction;
						Q[31]<= A[31];
					if(subtraction == 31'b0)
						Q[31]<=1'b0;

					end
				end	

end
endmodule