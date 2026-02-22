//design code for mulitplexer 4 to 1 
module mux4to1(
    input  [3:0] i,
    input  [1:0] sel,
    output logic y
);
  assign y = i[sel];
endmodule

