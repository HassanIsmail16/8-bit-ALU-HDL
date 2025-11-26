module logic_8_tb;
  reg[7:0] A, B;
  reg[2:0] Op;
  wire[7:0] Result;
  
  logic_8 uut(.A(A), .B(B), .AluOp(Op), .Result(Result));
  
  initial begin
    $display("Testing Logic Unit");
    $display("Op\tA\t\tB\t\tResult");
    
    A = 8'b11110000; B = 8'b10101010;
    
    // Test NOT (Op = 000)
    Op = 3'b000;
    #10 $display("%b\t%b\t%b\t%b (NOT A)", Op, A, B, Result);
    
    // Test AND (Op = 001)
    Op = 3'b001;
    #10 $display("%b\t%b\t%b\t%b (AND)", Op, A, B, Result);
    
    // Test OR (Op = 010)
    Op = 3'b010;
    #10 $display("%b\t%b\t%b\t%b (OR)", Op, A, B, Result);
    
    // Test NAND (Op = 011)
    Op = 3'b011;
    #10 $display("%b\t%b\t%b\t%b (NAND)", Op, A, B, Result);
    
    // Test Left Rotate (Op = 100)
    A = 8'b10000001;
    Op = 3'b100;
    #10 $display("%b\t%b\t%b\t%b (Left Rotate)", Op, A, B, Result);
    
    // Test Right Rotate (Op = 101)
    Op = 3'b101;
    #10 $display("%b\t%b\t%b\t%b (Right Rotate)", Op, A, B, Result);
    
    $finish;
  end
endmodule