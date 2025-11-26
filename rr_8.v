module rr_8 (
  input[7:0] A,
  output[7:0] Result
);
  assign Result = {A[0], A[7:1]};
endmodule