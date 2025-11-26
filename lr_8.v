module lr_8 (
  input[7:0] A,
  output[7:0] Result
);
  assign Result = {A[6:0], A[7]};
endmodule