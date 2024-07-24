`ifndef CPU_PARAM
`define CPU_PARAM
    `define ADD 'b000
    `define RF_WSEL_PC4 2'b00 
    `define RF_WSEL_SEXT 2'b01
    `define RF_WSEL_ALU 2'b10
    `define RF_WSEL_DRAM 2'b11
    
    `define SEXT_OP_I_S 3'b000 //I型有符号
    `define SEXT_OP_I_U 3'b001 //I型无符号
    `define SEXT_OP_S 3'b010 //S型
    `define SEXT_OP_B 3'b011 //B型
    `define SEXT_OP_U 3'b101 //U型
    `define SEXT_OP_J 3'b110 //J型
    
    `define NPC_OP_NEXT 2'b00   //顺序执行
    `define NPC_OP_OFFSET 2'b01 //跳转
    `define NPC_OP_JALR 2'b10   //jalr

    `define ALUB_RD2 1'b0
    `define ALUB_EXT 1'b1
    




`endif
