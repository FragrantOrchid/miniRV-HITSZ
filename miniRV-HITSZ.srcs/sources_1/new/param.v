`ifndef CPU_PARAM
`define CPU_PARAM
    `define ADD 'b000
    `define RF_WSEL_PC4 2'b00 
    `define RF_WSEL_ext 2'b01
    `define RF_WSEL_C 2'b10
    `define RF_WSEL_rdo 2'b11
    
    `define SEXT_OP_I_S 3'b000 //I���з���
    `define SEXT_OP_I_U 3'b001 //I���޷���
    `define SEXT_OP_S 3'b010 //S��
    `define SEXT_OP_B 3'b011 //B��
    `define SEXT_OP_U 3'b101 //U��
    `define SEXT_OP_J 3'b110 //J��





`endif
