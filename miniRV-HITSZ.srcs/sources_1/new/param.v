`ifndef CPU_PARAM
`define CPU_PARAM
    `define ZERO_32 32'h00000000
    
    `define WSEL_PC4 2'b00 
    `define WSEL_SEXT 2'b01
    `define WSEL_ALU 2'b10
    `define WSEL_DRAM 2'b11
    
    
    `define SEXT_OP_S 3'b010 //S型
    `define SEXT_OP_B 3'b011 //B型
    `define SEXT_OP_U 3'b101 //U型
    `define SEXT_OP_J 3'b110 //J型
    `define SEXT_OP_I 3'b000 //I型
    
    `define NPC_OP_NEXT 2'b00   //顺序执行
    `define NPC_OP_OFFSET 2'b01 //跳转
    `define NPC_OP_JALR 2'b10   //jalr
    `define NPC_OP_JAL 2'b11    //jal

    `define ALUB_RD2 1'b0
    `define ALUB_EXT 1'b1
    
    `define ENABLE 1'b1
    `define DISABLE 1'b0
    




`endif
