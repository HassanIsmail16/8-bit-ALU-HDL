module arithmetic_8_tb;
  reg[7:0] A, B;
  reg[2:0] AluOp;
  wire[7:0] Result;
  wire Cout;
  
  // Instantiate the arithmetic unit
  arithmetic_8 uut(
    .A(A), 
    .B(B), 
    .AluOp(AluOp), 
    .Result(Result), 
    .Cout(Cout)
  );
  
  initial begin
    $display("Testing Arithmetic Unit");
    $display("Time\tAluOp\tA\tB\tResult\tCout\tOperation");
    $display("--------------------------------------------------------");
    
    // Test Addition (AluOp = 000: A + B)
    A = 8'd15; B = 8'd10; AluOp = 3'b000;
    #10 $display("%0t\t%b\t%d\t%d\t%d\t%b\tA + B", $time, AluOp, A, B, Result, Cout);
    
    // Test Addition with carry out
    A = 8'd200; B = 8'd100; AluOp = 3'b000;
    #10 $display("%0t\t%b\t%d\t%d\t%d\t%b\tA + B (overflow)", $time, AluOp, A, B, Result, Cout);
    
    // Test Reverse Subtraction (AluOp = 001: B - A)
    A = 8'd10; B = 8'd25; AluOp = 3'b001;
    #10 $display("%0t\t%b\t%d\t%d\t%d\t%b\tB - A", $time, AluOp, A, B, Result, Cout);
    
    // Test Reverse Subtraction (negative result)
    A = 8'd30; B = 8'd10; AluOp = 3'b001;
    #10 $display("%0t\t%b\t%d\t%d\t%d\t%b\tB - A (negative)", $time, AluOp, A, B, Result, Cout);
    
    // Test Increment (AluOp = 010: A + 1)
    A = 8'd50; B = 8'd0; AluOp = 3'b010;
    #10 $display("%0t\t%b\t%d\t%d\t%d\t%b\tA + 1", $time, AluOp, A, B, Result, Cout);
    
    // Test Increment at boundary
    A = 8'd255; B = 8'd0; AluOp = 3'b010;
    #10 $display("%0t\t%b\t%d\t%d\t%d\t%b\tA + 1 (wrap)", $time, AluOp, A, B, Result, Cout);
    
    // Test Set on Equal - equal values (AluOp = 101: A == B)
    A = 8'd42; B = 8'd42; AluOp = 3'b101;
    #10 $display("%0t\t%b\t%d\t%d\t%d\t%b\tA == B (equal)", $time, AluOp, A, B, Result, Cout);
    
    // Test Set on Equal - different values
    A = 8'd42; B = 8'd43; AluOp = 3'b101;
    #10 $display("%0t\t%b\t%d\t%d\t%d\t%b\tA == B (not equal)", $time, AluOp, A, B, Result, Cout);
    
    // Test Logical Shift Left (AluOp = 110: B << 1)
    A = 8'b00001111; B = 8'd0; AluOp = 3'b110;
    #10 $display("%0t\t%b\t%b\t%d\t%b\t%b\tA << 1", $time, AluOp, A, B, Result, Cout);
    
    // Test Logical Shift Left with MSB set
    A = 8'b10000001; B = 8'd0; AluOp = 3'b110;
    #10 $display("%0t\t%b\t%b\t%d\t%b\t%b\tA << 1 (MSB set)", $time, AluOp, A, B, Result, Cout);
    
    // Test Logical Shift Right (AluOp = 111: B >> 1)
    A = 8'b11110000; B = 8'd0; AluOp = 3'b111;
    #10 $display("%0t\t%b\t%b\t%d\t%b\t%b\tA >> 1", $time, AluOp, A, B, Result, Cout);
    
    // Test Logical Shift Right with LSB set
    A = 8'b00001111; B = 8'd0; AluOp = 3'b111;
    #10 $display("%0t\t%b\t%b\t%d\t%b\t%b\tA >> 1 (LSB set)", $time, AluOp, A, B, Result, Cout);
    
    $display("--------------------------------------------------------");
    $display("Testing complete!");
    $finish;
  end
endmodule