module ALU_8 (
  output [7:0] Result,
  output Zero,
  output Negative,
  output Overflow,
  input [7:0] A, B,
  input [3:0] AluOp
);
  wire[7:0] arithmetic_result, logic_result;
  wire Cout;

  arithmetic_8 arithmetic_unit(
    .A(A),
    .B(B),
    .AluOp(AluOp[2:0]),
    .Result(arithmetic_result),
    .Cout(Cout)
  );

  logic_8 logic_unit(
    .A(A),
    .B(B),
    .AluOp(AluOp[2:0]),
    .Result(logic_result)
  );

  mux_2to1_8 result_mux(
    .A(arithmetic_result),
    .B(logic_result),
    .Sel(AluOp[3]),
    .Result(Result)
  );

  assign Zero = (Result == 8'b00000000) ? 1'b1 : 1'b0;
  assign Negative = Result[7];
  assign Overflow = (AluOp[3] == 1'b0) ? 
                    ((AluOp[2:0] == 3'b000 || AluOp[2:0] == 3'b001) ? 
                      ((A[7] == B[7]) && (Result[7] != A[7]) ? 1'b1 : 1'b0) 
                      : 1'b0) 
                    : 1'b0;

endmodule