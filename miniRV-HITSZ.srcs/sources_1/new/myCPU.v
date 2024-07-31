`timescale 1ns / 1ps

`include "defines.vh"

module myCPU (
    input  wire         cpu_rst,    //High active
    input  wire         cpu_clk,

    // Interface to IROM
`ifdef RUN_TRACE
    output wire [15:0]  inst_addr,
`else
    output wire [13:0]  inst_addr,
`endif
    input  wire [31:0]  inst,
    
    // Interface to Bridge
    output wire [31:0]  Bus_addr,
    input  wire [31:0]  Bus_rdata,
    output wire         Bus_we,
    output wire [31:0]  Bus_wdata

`ifdef RUN_TRACE
    ,// Debug Interface
    output wire         debug_wb_have_inst,
    output wire [31:0]  debug_wb_pc,
    output              debug_wb_ena,
    output wire [ 4:0]  debug_wb_reg,
    output wire [31:0]  debug_wb_value
`endif
);

    wire [31:0] PC_pc;
    wire [31:0] NPC_MUX_npc;
    wire [31:0] PC_ADD_naddr;
    
    wire [31:0] ALU_aluC;
    wire        BCOMP_beq;
    wire        BCOMP_blt;
    wire [31:0] WB_MUX_wbD;
    wire [31:0] RF_rD1;
    wire [31:0] RF_rD2;
    wire [31:0] IMM_GEN_imm;
    wire [31:0] AMUX_opA;
    wire [31:0] BMUX_opB;
       
    //control signals    
    wire        Ctrl_RFWen;
    wire        Ctrl_DRAMWen;
    wire        Ctrl_PCSel;
    wire  [2:0] Ctrl_BCOMPEn;
    wire  [3:0] Ctrl_IMMSel;
    wire  [3:0] Ctrl_ALUSel;
    wire        Ctrl_ASel;
    wire        Ctrl_BSel;
    wire  [1:0] Ctrl_WBSel;
    
    //pipeline register interface
    wire [31:0] IF_ID_inst;
    wire [31:0] IF_ID_naddr;
    wire [31:0] IF_ID_pc;
    
    wire        ID_EXE_RFWen;
    wire        ID_EXE_DRAMWen;
    wire        ID_EXE_PCSel;
    wire  [2:0] ID_EXE_BCOMPEn;
    wire  [3:0] ID_EXE_ALUSel;
    wire        ID_EXE_ASel;
    wire        ID_EXE_BSel;
    wire  [1:0] ID_EXE_WBSel;
    wire [31:0] ID_EXE_RF_rD1;
    wire [31:0] ID_EXE_RF_rD2;
    wire [31:0] ID_EXE_imm;
    wire [31:0] ID_EXE_pc;
    wire [31:0] ID_EXE_naddr;
    wire  [4:0] ID_EXE_wR;
    
    wire        EXE_MEM_RFWen;
    wire        EXE_MEM_DRAMWen;
    wire        EXE_MEM_PCSel;
    wire [1:0]  EXE_MEM_WBSel;
    wire [31:0] EXE_MEM_RF_rD2;
    wire [31:0] EXE_MEM_imm;
    wire [31:0] EXE_MEM_pc;
    wire [31:0] EXE_MEM_naddr;
    wire        EXE_MEM_beq;
    wire        EXE_MEM_blt;
    wire [31:0] EXE_MEM_aluC;
    wire  [4:0] EXE_MEM_wR;
    
    wire        MEM_WB_RFWen;
    wire        MEM_WB_PCSel;
    wire [1:0]  MEM_WB_WBSel;
    wire [31:0] MEM_WB_imm;
    wire [31:0] MEM_WB_pc;
    wire [31:0] MEM_WB_naddr;
    wire        MEM_WB_beq;
    wire        MEM_WB_blt;
    wire [31:0] MEM_WB_aluC;
    wire [31:0] MEM_WB_rdout;
    wire  [4:0] MEM_WB_wR;
    
    //stop pipeline register signal
    wire        stop_PC;
    wire        stop_PC_NPC_MUX;
    wire        stop_IF_ID;
    wire        stop_ID_EXE;
//    wire        stop_EXE_MEM;
//    wire        stop_MEM_WB;
    
    wire        Det_conflict_ID_EXE;
    wire        Det_conflict_EXE_MEM;
    wire        Det_conflict_MEM_WB;    
    reg [31:0]  last_WBperformed_pc;
`ifdef RUN_TRACE
    reg [31:0]  debug_last_Finish_pc;
    reg         debug_start_flow;
`endif                    

`ifdef RUN_TRACE
    // Debug Interface
    assign debug_wb_have_inst =  debug_start_flow && (debug_last_Finish_pc != MEM_WB_pc)/* TODO */;
    assign debug_wb_pc        =  MEM_WB_pc/* TODO */;
    assign debug_wb_ena       =  MEM_WB_RFWen/* TODO */;
    assign debug_wb_reg       =  MEM_WB_wR/* TODO */;
    assign debug_wb_value     =  WB_MUX_wbD/* TODO */;
`endif

    
    
    //IF
    PC U_PC(
            .clk(cpu_clk),
            .rst(cpu_rst),
            .stop_PC(stop_PC),
            .stop_PC_NPC_MUX(stop_PC_NPC_MUX),
            .npc(NPC_MUX_npc),
            .pc(PC_pc)
            );
            
    `ifdef RUN_TRACE
        assign inst_addr = PC_pc[17:2];
    `else
        assign inst_addr = PC_pc[15:2]; 
    `endif        
    
    PC_ADD  U_PC_ADD(
            .pc(PC_pc),
            .naddr(PC_ADD_naddr)
            );  
         
    NPC_MUX U_NPC_MUX(
            .naddr(PC_ADD_naddr),
            .baddr(EXE_MEM_aluC),
            .pc(PC_pc),
            .EXE_MEM_pc(EXE_MEM_pc),
            .beq(EXE_MEM_beq),
            .blt(EXE_MEM_blt),
            .funct3(inst[14:12]),           
            .opcode(inst[6:0]),
            .stop_PC(stop_PC_NPC_MUX),
            .npc(NPC_MUX_npc)
            );
    
            
    //IF_ID
    IF_ID   U_IF_ID(
            .cpu_rst(cpu_rst),
            .cpu_clk(cpu_clk),
            .stop_IF_ID(stop_IF_ID),
            .PC_pc(PC_pc),
            .PC_ADD_naddr(PC_ADD_naddr),
            .inst(inst),
            .IF_ID_inst(IF_ID_inst),
            .IF_ID_naddr(IF_ID_naddr),
            .IF_ID_pc(IF_ID_pc)
            );
                    
    //ID  
    
    Detect_RAW  U_Detect_RAW(
            .opcode(IF_ID_inst[6:0]),
            .RF_rR1(IF_ID_inst[19:15]),
            .RF_rR2(IF_ID_inst[24:20]),
            .ID_EXE_RFWen(ID_EXE_RFWen),
            .EXE_MEM_RFWen(EXE_MEM_RFWen),
            .MEM_WB_RFWen(MEM_WB_RFWen),
            .ID_EXE_wR(ID_EXE_wR),
            .EXE_MEM_wR(EXE_MEM_wR),
            .MEM_WB_wR(MEM_WB_wR),
            .last_WBperformed_pc(last_WBperformed_pc),
            .ID_EXE_pc(ID_EXE_pc),
            .EXE_MEM_pc(EXE_MEM_pc),
            .MEM_WB_pc(MEM_WB_pc),
            .conflict_ID_EXE(Det_conflict_ID_EXE),
            .conflict_EXE_MEM(Det_conflict_EXE_MEM),
            .conflict_MEM_WB (Det_conflict_MEM_WB)
            );
                      
    Process_RAW U_Process_RAW(
            //.clk(cpu_clk),
            .conflict_ID_EXE(Det_conflict_ID_EXE),
            .conflict_EXE_MEM(Det_conflict_EXE_MEM),
            .conflict_MEM_WB(Det_conflict_MEM_WB),
            .stop_PC(stop_PC),
            .stop_IF_ID(stop_IF_ID),
            .stop_ID_EXE(stop_ID_EXE)
            );
            
            
    RF U_RF(
            .clk(cpu_clk),
            .rR1(IF_ID_inst[19:15]),
            .rR2(IF_ID_inst[24:20]),
            .wR(MEM_WB_wR),
            .wD(WB_MUX_wbD),
            .RFWen(MEM_WB_RFWen),
            .rD1(RF_rD1),
            .rD2(RF_rD2)
            );      
                          
    IMM_GEN U_IMM_GEN(
            .immIn(IF_ID_inst[31:7]),
            .IMMSel(Ctrl_IMMSel),
            .imm(IMM_GEN_imm)
            );
    
    Controler U_Controler(
            .rst(cpu_rst),
            .opcode(IF_ID_inst[6:0]),
            .funct3(IF_ID_inst[14:12]),
            .funct7(IF_ID_inst[31:25]),
            .RFWen(Ctrl_RFWen),
            .DRAMWen(Ctrl_DRAMWen),
            .PCSel(Ctrl_PCSel),
            .BCOMPEn(Ctrl_BCOMPEn),
            .IMMSel(Ctrl_IMMSel),
            .ALUSel(Ctrl_ALUSel),
            .ASel(Ctrl_ASel),
            .BSel(Ctrl_BSel),
            .WBSel(Ctrl_WBSel)
            );
            
    
    
    //ID_EXE
    ID_EXE  U_ID_EXE(
            .cpu_rst(cpu_rst),
            .cpu_clk(cpu_clk),
            .stop_ID_EXE(stop_ID_EXE),
            .Ctrl_RFWen(Ctrl_RFWen),
            .Ctrl_DRAMWen(Ctrl_DRAMWen),
            .Ctrl_PCSel(Ctrl_PCSel),
            .Ctrl_BCOMPEn(Ctrl_BCOMPEn),
            .Ctrl_ALUSel(Ctrl_ALUSel),
            .Ctrl_ASel(Ctrl_ASel),
            .Ctrl_BSel(Ctrl_BSel),
            .Ctrl_WBSel(Ctrl_WBSel),
            .RF_rD1(RF_rD1),
            .RF_rD2(RF_rD2),
            .IMM_GEN_imm(IMM_GEN_imm),
            .IF_ID_pc(IF_ID_pc),
            .IF_ID_naddr(IF_ID_naddr),
            .inst_wR(IF_ID_inst[11:7]),
            
            .ID_EXE_RFWen(ID_EXE_RFWen),
            .ID_EXE_DRAMWen(ID_EXE_DRAMWen),
            .ID_EXE_PCSel(ID_EXE_PCSel),
            .ID_EXE_BCOMPEn(ID_EXE_BCOMPEn),
            .ID_EXE_ALUSel(ID_EXE_ALUSel),
            .ID_EXE_ASel(ID_EXE_ASel),
            .ID_EXE_BSel(ID_EXE_BSel),
            .ID_EXE_WBSel(ID_EXE_WBSel),
            .ID_EXE_RF_rD1(ID_EXE_RF_rD1),
            .ID_EXE_RF_rD2(ID_EXE_RF_rD2),
            .ID_EXE_imm(ID_EXE_imm),
            .ID_EXE_pc(ID_EXE_pc),
            .ID_EXE_naddr(ID_EXE_naddr),
            .ID_EXE_wR(ID_EXE_wR)
            );
                    
    //EXE
    ALU U_ALU(
            .opA(AMUX_opA),
            .opB(BMUX_opB),
            .ALUSel(ID_EXE_ALUSel),
            .C(ALU_aluC)
            );
            
    AMUX U_AMUX(
            .data1(ID_EXE_RF_rD1),
            .pc(ID_EXE_pc),
            .ASel(ID_EXE_ASel),
            .opA(AMUX_opA)
            );
            
    BMUX U_BMUX(
            .data2(ID_EXE_RF_rD2),
            .imm(ID_EXE_imm),
            .BSel(ID_EXE_BSel),
            .opB(BMUX_opB)
            ); 
                           
    BCOMP U_BCOMP(
            .data1(ID_EXE_RF_rD1),
            .data2(ID_EXE_RF_rD2),
            .BCOMPEn(ID_EXE_BCOMPEn),
            .beq(BCOMP_beq),
            .blt(BCOMP_blt)
            );
            
    //EXE_MEM
    EXE_MEM U_EXE_MEM(
            .cpu_rst(cpu_rst),
            .cpu_clk(cpu_clk),
            //.stop_EXE_MEM(stop_EXE_MEM),
            .ID_EXE_RFWen(ID_EXE_RFWen),
            .ID_EXE_DRAMWen(ID_EXE_DRAMWen),
            .ID_EXE_PCSel(ID_EXE_PCSel),
            .ID_EXE_WBSel(ID_EXE_WBSel),
            .ID_EXE_RF_rD2(ID_EXE_RF_rD2),
            .ID_EXE_imm(ID_EXE_imm),
            .ID_EXE_pc(ID_EXE_pc),
            .ID_EXE_naddr(ID_EXE_naddr),
            .BCOMP_beq(BCOMP_beq),
            .BCOMP_blt(BCOMP_blt),
            .ALU_aluC(ALU_aluC),
            .ID_EXE_wR(ID_EXE_wR),
            
            .EXE_MEM_RFWen(EXE_MEM_RFWen),
            .EXE_MEM_DRAMWen(EXE_MEM_DRAMWen),
            .EXE_MEM_PCSel(EXE_MEM_PCSel),
            .EXE_MEM_WBSel(EXE_MEM_WBSel),
            .EXE_MEM_RF_rD2(EXE_MEM_RF_rD2),
            .EXE_MEM_imm(EXE_MEM_imm),
            .EXE_MEM_pc(EXE_MEM_pc),
            .EXE_MEM_naddr(EXE_MEM_naddr),
            .EXE_MEM_beq(EXE_MEM_beq),
            .EXE_MEM_blt(EXE_MEM_blt),
            .EXE_MEM_aluC(EXE_MEM_aluC),
            .EXE_MEM_wR(EXE_MEM_wR)
            );
            
    //MEM
    assign Bus_addr     = EXE_MEM_aluC;
    assign Bus_wdata    = EXE_MEM_RF_rD2;
    assign Bus_we       = EXE_MEM_DRAMWen;
    
    //MEM_WB
    MEM_WB  U_MEM_WB(
            .cpu_rst(cpu_rst),
            .cpu_clk(cpu_clk),
            .EXE_MEM_RFWen(EXE_MEM_RFWen),
            .EXE_MEM_PCSel(EXE_MEM_PCSel),
            .EXE_MEM_WBSel(EXE_MEM_WBSel),
            .EXE_MEM_imm(EXE_MEM_imm),
            .EXE_MEM_pc(EXE_MEM_pc),
            .EXE_MEM_naddr(EXE_MEM_naddr),
            .EXE_MEM_beq(EXE_MEM_beq),
            .EXE_MEM_blt(EXE_MEM_blt),
            .EXE_MEM_aluC(EXE_MEM_aluC),
            .DRAM_rdout(Bus_rdata),
            .EXE_MEM_wR(EXE_MEM_wR),
            
            .MEM_WB_RFWen(MEM_WB_RFWen),
            .MEM_WB_WBSel(MEM_WB_WBSel),
            .MEM_WB_imm(MEM_WB_imm),
            .MEM_WB_pc(MEM_WB_pc),
            .MEM_WB_naddr(MEM_WB_naddr),
            .MEM_WB_aluC(MEM_WB_aluC),
            .MEM_WB_rdout(MEM_WB_rdout),
            .MEM_WB_wR(MEM_WB_wR)
            );
    always @(posedge cpu_clk or posedge cpu_rst)begin
        if(cpu_rst)last_WBperformed_pc <= 32'hFFFF_FFFC;
        else last_WBperformed_pc <= MEM_WB_RFWen?MEM_WB_pc:last_WBperformed_pc;
    end    
    
    //WB
    WB_MUX U_WB_MUX(
            .uimm(MEM_WB_imm),
            .aluC(MEM_WB_aluC),
            .naddr(MEM_WB_naddr),
            .rdout(MEM_WB_rdout),
            .WBSel(MEM_WB_WBSel),
            .wbD(WB_MUX_wbD)
            );
            

`ifdef RUN_TRACE
    reg  [2:0]  debug_cnt_flow;
    wire        debug_flow;
    assign     debug_flow = (debug_cnt_flow == 3'd4);
    
    always @(posedge cpu_clk or posedge cpu_rst)begin
        if(cpu_rst) debug_cnt_flow <= 3'b0;
        else debug_cnt_flow <= debug_cnt_flow + 1'b1;
    end
    
    always @(posedge cpu_clk or posedge cpu_rst)begin
        if(cpu_rst) debug_start_flow <= 1'b0;
        else debug_start_flow <= ( (!debug_start_flow) && debug_flow)?1'b1:debug_start_flow;
    end   
    
    
    always @(posedge cpu_clk or posedge cpu_rst)begin
        debug_last_Finish_pc <= (cpu_rst || (!debug_start_flow) )?32'hFFFF_FFFC:MEM_WB_pc;
    end
`endif
    


endmodule
