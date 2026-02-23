`include "alu_modes.sv"

//module for alu , with 32 bit width of data is input
//parameter width is evaluted in compile time wherever in the design is there it goes to there and replace width with 32
module alu #(parameter WIDTH=32)(
  input  logic [WIDTH-1:0] a,
  input  logic [WIDTH-1:0] b,
  //from typedef it acts as input logic [3:0]sel_mode
  input  alu_mode sel_mode,
  output logic [WIDTH-1:0] result,
  output logic carry
);

  //for doing addtion and substraction and storing for carry aslo
  logic [WIDTH:0] result_ext;

  //alwayscomb is sv construct to avoid sensitivity list errors 
  always_comb begin
    result_ext='0;
    result='0;
    carry=1'b0;
    unique case(sel_mode)
      ALU_ADD:begin
        result_ext=a+b;
        result=result_ext[WIDTH-1:0];
        carry=result_ext[WIDTH];
      end
      ALU_SUB:begin
        result_ext=a-b;
        result=result_ext[WIDTH-1:0];
        carry=result_ext[WIDTH];
      end
      ALU_AND: result=a&b;
      ALU_OR : result=a|b;
      ALU_XOR: result=a^b;
      ALU_SLL: result=a<<b[$clog2(WIDTH)-1:0];
      ALU_SRL: result=a>>b[$clog2(WIDTH)-1:0];
      ALU_MUL: result=a*b;
      default: result='0;
    endcase
  end
endmodule