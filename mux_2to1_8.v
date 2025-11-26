module mux_2to1_8 (
  input[7:0] A, B,
  input Sel,
  output[7:0] Result
);
  assign Result = Sel ? B : A; // B -> 1, A -> 0
endmodule