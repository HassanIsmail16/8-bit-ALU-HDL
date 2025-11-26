module rs_8 (
  input[7:0] A,
  output[7:0] Result
);
  assign Result = A >>> 1;
endmodule