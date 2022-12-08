module BC(
input CLK,
input FGI,
output [11:0] PC,
output [11:0] AR,
output [15:0] IR,
output [15:0] AC,
output [15:0] DR
);



control_unit(
.CLK(CLK),
.INTERRUPT_R(INTERRUPT_R) 
);

endmodule