module datapath(
input CLK,
input E,
input AR_RESET, AR_INC, AR_WRITE,
input [11:0] AR_INP, 
input [11:0] AR_OUT,

input PC_RESET, PC_INC, PC_WRITE,
input [11:0] PC_INP, 
input [11:0] PC_OUT,

input AC_RESET, AC_INC, AC_WRITE,
input [11:0] AC_INP, 
input [11:0] AC_OUT,

input DR_RESET, DR_INC, DR_WRITE,
input [11:0] DR_INP, 
input [11:0] DR_OUT,

input IR_RESET, IR_INC, IR_WRITE,
input [11:0] IR_INP, 
input [11:0] IR_OUT,

input TR_RESET, TR_INC, TR_WRITE,
input [11:0] TR_INP, 
input [11:0] TR_OUT,

input [15:0] BUS_OUTPUT,

input WRITE_ENABLE, READ_ENABLE,
input [15:0] READ_MEMORY,
input [15:0] WRITE_MEMORY,
input [11:0] INP_ADD,
input [3:0] SEL,
output OVF, CO, N, Z
);



register #(.WIDTH(12)) PC (.CLK(CLK), .RESET(PC_RESET), .INC(PC_INC), .WRITE(PC_WRITE), .LOAD(BUS_OUTPUT), .OUT(PC_OUT));
register #(.WIDTH(12)) AR (.CLK(CLK), .RESET(AR_RESET), .INC(AR_INC), .WRITE(AR_WRITE), .LOAD(BUS_OUTPUT), .OUT(AR_OUT));
register #(.WIDTH(16)) AC (.CLK(CLK), .RESET(AC_RESET), .INC(AC_INC), .WRITE(AC_WRITE), .LOAD(AC_INP), 	  .OUT(AC_OUT));
register #(.WIDTH(16)) TR (.CLK(CLK), .RESET(TR_RESET), .INC(TR_INC), .WRITE(TR_WRITE), .LOAD(BUS_OUTPUT), .OUT(TR_OUT));
register #(.WIDTH(16)) DR (.CLK(CLK), .RESET(DR_RESET), .INC(DR_INC), .WRITE(DR_WRITE), .LOAD(BUS_OUTPUT), .OUT(DR_OUT));
register #(.WIDTH(16)) IR (.CLK(CLK), .RESET(IR_RESET), .INC(IR_INC), .WRITE(IR_WRITE), .LOAD(BUS_OUTPUT), .OUT(IR_OUT));

wire [7:0] muxINPUT;
assign muxINPUT[0] = 1;
assign muxINPUT[1] = AR_OUT;
assign muxINPUT[2] = PC_OUT;
assign muxINPUT[3] = DR_OUT;
assign muxINPUT[4] = AC_OUT;
assign muxINPUT[5] = IR_OUT;
assign muxINPUT[6] = TR_OUT;
assign muxINPUT[7] = READ_ENABLE;

mux8 BUS(.INP(muxINPUT), .SEL(SEL), .OUT(BUS_OUTPUT));

alu ALU(.CLK(CLK), .AC(AC), .DR(DR), .E(E), .SEL(SEL), .OUT(AC_INP), .OVF(OVF), .Z(Z), .N(N));
memory mem(.CLK(CLK), .WRITE_ENABLE(WRITE_ENABLE), .INP_ADD(INP_ADD), .OUT(READ_MEMORY));

endmodule