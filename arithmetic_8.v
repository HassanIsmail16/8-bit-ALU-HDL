module arithmetic_8 (
  input[7:0] A, B,
  input[2:0] AluOp, // for logic operations, msb is always 0, so we can use 3 bits
  output[7:0] Result,
  output Cout
);
  wire[7:0] adder_result, soe_result, ls_result, rs_result;
  wire[7:0] notA_result;
  wire[7:0] mux1_result, mux2_result, mux3_result, mux4_result;

  // arithmetic operations
  not_8 notA_inst(.A(A), .Result(notA_result));
  
  // first layer of muxes
  mux_2to1_8 mux1_inst(.A(A), .B(notA_result), .Sel(AluOp[0]), .Result(mux1_result)); // A or ~A (for subtraction)
  mux_2to1_8 mux2_inst(.A(B), .B(8'b00000001), .Sel(AluOp[1]), .Result(mux2_result)); // B or 1 (for increment)

  adder_8 adder_inst(.A(mux1_result), .B(mux2_result), .Cin(AluOp[0]), .Sum(adder_result), .Cout(Cout)); // add/sub/inc

  xnor_8 soe_inst(.A(A), .B(B), .Result(soe_result)); // set on equal
  ls_8 ls_inst(.A(A), .Result(ls_result)); // logical shift left
  rs_8 rs_inst(.A(A), .Result(rs_result)); // logical shift right

  // second layer of muxes
  mux_2to1_8 mux3_inst(.A(ls_result), .B(rs_result), .Sel(AluOp[0]), .Result(mux3_result)); // ls or rs

  // third layer of muxes
  mux_2to1_8 mux4_inst(.A(soe_result), .B(mux3_result), .Sel(AluOp[1]), .Result(mux4_result)); // soe or (ls/rs)

  // final mux (result)
  mux_2to1_8 mux5_inst(.A(adder_result), .B(mux4_result), .Sel(AluOp[2]), .Result(Result)); // (soe/(ls/rs)) or add/sub/inc
endmodule
