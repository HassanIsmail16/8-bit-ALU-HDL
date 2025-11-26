module ALU_8_tb;
  reg[7:0] A, B;
  reg[3:0] AluOp;
  wire[7:0] Result;
  wire Zero, Negative, Overflow;
  
  // Instantiate the ALU
  ALU_8 uut(
    .Result(Result),
    .Zero(Zero),
    .Negative(Negative),
    .Overflow(Overflow),
    .A(A),
    .B(B),
    .AluOp(AluOp)
  );
  
  initial begin
    $display("========================================");
    $display("       8-bit ALU Complete Test");
    $display("========================================");
    $display("AluOp\tA\tB\tResult\tZ N O\tOperation");
    $display("----------------------------------------");
    
    // ============ ARITHMETIC OPERATIONS ============
    $display("\n--- ARITHMETIC OPERATIONS ---");
    
    // Test 0000: A + B
    A = 8'd15; B = 8'd10; AluOp = 4'b0000;
    #10 $display("%b\t%d\t%d\t%d\t%b %b %b\tA + B", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 0000: Addition with overflow (positive + positive = negative)
    A = 8'd100; B = 8'd50; AluOp = 4'b0000;
    #10 $display("%b\t%d\t%d\t%d\t%b %b %b\tA + B (overflow)", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 0000: Addition resulting in zero
    A = 8'd0; B = 8'd0; AluOp = 4'b0000;
    #10 $display("%b\t%d\t%d\t%d\t%b %b %b\tA + B (zero)", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 0001: B - A (Reverse Subtraction)
    A = 8'd10; B = 8'd25; AluOp = 4'b0001;
    #10 $display("%b\t%d\t%d\t%d\t%b %b %b\tB - A", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 0001: B - A (negative result)
    A = 8'd30; B = 8'd10; AluOp = 4'b0001;
    #10 $display("%b\t%d\t%d\t%d\t%b %b %b\tB - A (negative)", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 0001: B - A resulting in zero
    A = 8'd20; B = 8'd20; AluOp = 4'b0001;
    #10 $display("%b\t%d\t%d\t%d\t%b %b %b\tB - A (zero)", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 0010: A + 1 (Increment)
    A = 8'd42; B = 8'd0; AluOp = 4'b0010;
    #10 $display("%b\t%d\t%d\t%d\t%b %b %b\tA + 1", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 0010: Increment with wraparound
    A = 8'd255; B = 8'd0; AluOp = 4'b0010;
    #10 $display("%b\t%d\t%d\t%d\t%b %b %b\tA + 1 (wrap)", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 0101: Set on Equal (equal)
    A = 8'd77; B = 8'd77; AluOp = 4'b0101;
    #10 $display("%b\t%d\t%d\t%d\t%b %b %b\tA == B (true)", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 0101: Set on Equal (not equal)
    A = 8'd77; B = 8'd78; AluOp = 4'b0101;
    #10 $display("%b\t%d\t%d\t%d\t%b %b %b\tA == B (false)", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 0110: Logical Shift Left
    A = 8'b00001111; B = 8'd0; AluOp = 4'b0110;
    #10 $display("%b\t%b\t%d\t%b\t%b %b %b\tB << 1", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 0111: Logical Shift Right
    A = 8'b11110000; B = 8'd0; AluOp = 4'b0111;
    #10 $display("%b\t%b\t%d\t%b\t%b %b %b\tB >> 1", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // ============ LOGIC OPERATIONS ============
    $display("\n--- LOGIC OPERATIONS ---");
    
    // Test 1000: NOT A
    A = 8'b10101010; B = 8'b00000000; AluOp = 4'b1000;
    #10 $display("%b\t%b\t%b\t%b\t%b %b %b\tNOT A", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 1001: A AND B
    A = 8'b11110000; B = 8'b10101010; AluOp = 4'b1001;
    #10 $display("%b\t%b\t%b\t%b\t%b %b %b\tA AND B", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 1001: AND resulting in zero
    A = 8'b11110000; B = 8'b00001111; AluOp = 4'b1001;
    #10 $display("%b\t%b\t%b\t%b\t%b %b %b\tA AND B (zero)", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 1010: A OR B
    A = 8'b11110000; B = 8'b00001111; AluOp = 4'b1010;
    #10 $display("%b\t%b\t%b\t%b\t%b %b %b\tA OR B", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 1011: A NAND B
    A = 8'b11110000; B = 8'b10101010; AluOp = 4'b1011;
    #10 $display("%b\t%b\t%b\t%b\t%b %b %b\tA NAND B", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 1100: Rotate Left
    A = 8'b10000001; B = 8'b00000000; AluOp = 4'b1100;
    #10 $display("%b\t%b\t%b\t%b\t%b %b %b\tRotate A Left", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    // Test 1101: Rotate Right
    A = 8'b10000001; B = 8'b00000000; AluOp = 4'b1101;
    #10 $display("%b\t%b\t%b\t%b\t%b %b %b\tRotate A Right", 
                 AluOp, A, B, Result, Zero, Negative, Overflow);
    
    $display("========================================");
    $display("          Testing Complete!");
    $display("========================================");
    $finish;
  end
endmodule