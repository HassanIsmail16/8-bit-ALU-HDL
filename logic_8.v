module logic_8 (
  input[7:0] A, B,
  input[2:0] AluOp, // for logic operations, msb is always 1, so we can use 3 bits
  output[7:0] Result
);
  wire[7:0] lr_result, rr_result, and_result, not_result, or_result, nand_result;
  wire[7:0] mux1_result, mux2_result, mux3_result, mux4_result;

  // logic operations
  lr_8 lr_inst(.A(A), .Result(lr_result));
  rr_8 rr_inst(.A(A), .Result(rr_result));
  and_8 and_inst(.A(A), .B(B), .Result(and_result));
  not_8 not_inst(.A(A), .Result(not_result));
  or_8 or_inst(.A(A), .B(B), .Result(or_result));
  nand_8 nand_inst(.A(A), .B(B), .Result(nand_result));

  // first layer of muxes
  mux_2to1_8 mux1_inst(.A(lr_result), .B(rr_result), .Sel(AluOp[0]), .Result(mux1_result));
  mux_2to1_8 mux2_inst(.A(not_result), .B(and_result), .Sel(AluOp[0]), .Result(mux2_result));
  mux_2to1_8 mux3_inst(.A(or_result), .B(nand_result), .Sel(AluOp[0]), .Result(mux3_result));

  // second layer of muxes
  mux_2to1_8 mux4_inst(.A(mux2_result), .B(mux3_result), .Sel(AluOp[1]), .Result(mux4_result));
  
  // final mux (result)
  mux_2to1_8 mux5_inst(.A(mux4_result), .B(mux1_result), .Sel(AluOp[2]), .Result(Result));
endmodule

