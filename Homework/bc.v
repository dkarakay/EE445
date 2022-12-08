module bc(
input CLK,
input FGI,
output [11:0] PC,
output [11:0] AR,
output [15:0] IR,
output [15:0] AC,
output [15:0] DR
);



wire INTERRUPT_R;
wire E;
wire INDIRECT_BIT;
wire [15:0] TIME_SIGNAL;
wire [7:0]  DEC_SIGNAL;
wire MEMORY_READ, MEMORY_WRITE;
wire IR_LOAD;
wire TR_LOAD;
wire OUTR_LOAD;
wire ALU_LOAD, ALU_CLEAR, ALU_INC;
wire AR_LOAD, AR_INC, AR_CLEAR;
wire DR_LOAD, DR_INC;
wire PC_LOAD, PC_CLEAR, PC_INC;
wire [7:0] SIG;

control_unit(
.CLK(CLK),
.INTERRUPT_R(INTERRUPT_R), 
.IR(IR),
.DR(DR),
.AC(AC),
.E(E),
.INDIRECT_BIT(INDIRECT_BIT),
.TIME_SIGNAL(TIME_SIGNAL),
.DEC_SIGNAL(DEC_SIGNAL)
);

endmodule