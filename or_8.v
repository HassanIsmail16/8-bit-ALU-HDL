module or_8 (
  input[7:0] A, B,
  output[7:0] Result
);
  assign Result = A | B;
endmodule