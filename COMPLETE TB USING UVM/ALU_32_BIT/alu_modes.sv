//typedef in this design acts as parameters evaulated at compile time 
//acts as a input logic [3:0] sel_mode in design
`ifndef ALU_MODES_SV
`define ALU_MODES_SV
typedef enum logic [3:0]{
  ALU_ADD=4'd0,
  ALU_SUB=4'd1,
  ALU_AND=4'd2,
  ALU_OR=4'd3,
  ALU_XOR=4'd4,
  ALU_SLL=4'd5,
  ALU_SRL=4'd6,
  ALU_MUL=4'd7
} alu_mode;
`endif


  
//   modport dut(
//     input  a,
//     input  b,
//     input  sel_mode,
//     output result,
//     output carry
//   );
//   modport tb(
//     output a,
//     output b,
//     output sel_mode,
//     input  result,
//     input  carry
//   );