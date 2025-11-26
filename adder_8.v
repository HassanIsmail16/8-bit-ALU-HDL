module adder_8 (
  input[7:0] A, B,
  input Cin,
  output[7:0] Sum,
  output Cout
);
  assign {Cout, Sum} = A + B + Cin;
endmodule