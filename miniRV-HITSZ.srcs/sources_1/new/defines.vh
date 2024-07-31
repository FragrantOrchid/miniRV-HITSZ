// Annotate this macro before synthesis
 `define RUN_TRACE

// TODO: 在此处定义你的宏
// 基础数值
`define ENABLE 1'b1
`define DISABLE 1'b0
`define ZERO_32 32'h0000_0000
`define ZERO_24 24'h000_000

//
`define CNT_END    20'd25000

`define BCOMP_EQ   3'b100
`define BCOMP_NE   3'b101
`define BCOMP_LT   3'b110
`define BCOMP_GE   3'b111

`define IMMI   4'b1000
`define IMMIs  4'b1001
`define IMMS   4'b1010
`define IMMB   4'b1011
`define IMMU   4'b1100
`define IMMJ   4'b1101

`define OP_ADD      4'b1000
`define OP_SUB      4'b1001
`define OP_AND      4'b1010
`define OP_OR       4'b1011
`define OP_XOR      4'b1100
`define OP_SHIFT_LL 4'b1101
`define OP_SHIFT_RL 4'b1110
`define OP_SHIFT_RA 4'b1111

`define WB_ALUC    2'b00
`define WB_DRAM    2'b01
`define WB_NADDR   2'b10
`define WB_UIMM    2'b11

`define ZERO32 32'h0000_0000

// 外设I/O接口电路的端口地址
`define PERI_ADDR_DIG   32'hFFFF_F000
`define PERI_ADDR_LED   32'hFFFF_F060
`define PERI_ADDR_SW    32'hFFFF_F070
`define PERI_ADDR_BTN   32'hFFFF_F078
