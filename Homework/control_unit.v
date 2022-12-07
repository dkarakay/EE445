module control_unit(
input CLK,
input INTERRUPT_R,
input [15:0] IR,
input INDIRECT_BIT,
input [15:0] TIME_SIGNAL,
input [7:0]  DEC_SIGNAL,
output MEMORY_READ, MEMORY_WRITE,
output IR_LOAD,
output TR_LOAD,
output OUTR_LOAD,
output ALU_LOAD, ALU_CLEAR, ALU_INC,
output AR_LOAD, AR_INC, AR_CLEAR,
output DR_LOAD, DR_INC,
output PC_LOAD, PC_CLEAR, PC_INC
);


assign MEMORY_READ = (~INTERRUPT_R && TIME_SIGNAL[1]) 
|| (~DEC_SIGNAL[7] && INDIRECT_BIT && TIME_SIGNAL[3]) 
|| (TIME_SIGNAL[4] && (DEC_SIGNAL[0] 
	|| DEC_SIGNAL[1] 
	|| DEC_SIGNAL[2] 
	|| DEC_SIGNAL[6])
);

assign MEMORY_WRITE = (INTERRUPT_R && TIME_SIGNAL[1])
|| (DEC_SIGNAL[3] && TIME_SIGNAL[4])
|| (DEC_SIGNAL[5] && TIME_SIGNAL[4])
|| (DEC_SIGNAL[6] && TIME_SIGNAL[6]);


assign IR_LOAD = ~INTERRUPT_R && TIME_SIGNAL[1];
assign TR_LOAD =  INTERRUPT_R && TIME_SIGNAL[0];


assign AR_LOAD = ((~INTERRUPT_R && TIME_SIGNAL[0]) || (~INTERRUPT_R && TIME_SIGNAL[2]) || (INTERRUPT_R && TIME_SIGNAL[3] && DEC_SIGNAL[7]));

assign AR_INC   = DEC_SIGNAL[5] && TIME_SIGNAL[4];
assign AR_CLEAR = INTERRUPT_R && TIME_SIGNAL[0];


assign ALU_LOAD = (TIME_SIGNAL[5] && (DEC_SIGNAL[0] || DEC_SIGNAL[1] || DEC_SIGNAL[2])
|| ((DEC_SIGNAL[7] && ~INTERRUPT_R && TIME_SIGNAL[3]) && (IR[9] || IR[7] || IR[6]))
||  (DEC_SIGNAL[7] && INTERRUPT_R && TIME_SIGNAL[3] && IR[11])
);

assign ALU_CLEAR = (DEC_SIGNAL[7] && ~INTERRUPT_R && TIME_SIGNAL[3] && IR[11]);

assign ALU_INC = (DEC_SIGNAL[7] && ~INTERRUPT_R && TIME_SIGNAL[3] && IR[5]);


assign PC_LOAD = (DEC_SIGNAL[4] && TIME_SIGNAL[4]) || (DEC_SIGNAL[5] && TIME_SIGNAL[5]); 

assign PC_CLEAR = (INTERRUPT_R && TIME_SIGNAL[1]); 

//assign PC_INC = ((INTERRUPT_R && TIME_SIGNAL[1])
//|| (INTERRUPT_R && TIME_SIGNAL[2])/
//); 

assign DR_INC = (DEC_SIGNAL[6] && TIME_SIGNAL[5]);

assign DR_LOAD = (TIME_SIGNAL[4] && (DEC_SIGNAL[0] || DEC_SIGNAL[1] || DEC_SIGNAL[2] || DEC_SIGNAL[6]));

endmodule