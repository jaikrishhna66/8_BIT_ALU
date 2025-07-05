`timescale 1ns / 1ps
module alu_8bit_tb;
	// Inputs
	reg CLK;
	reg RST;
	reg [7:0] A;
	reg [7:0] B;
	reg [3:0] ALU_SEL;
	// Outputs
	wire [15:0] ALU_OUT;
	wire CAR_FLAG;
	// Instantiate the Unit Under Test (UUT)
	alu_8bit uut (
		.CLK(CLK), 
		.RST(RST), 
		.A(A), 
		.B(B), 
		.ALU_SEL(ALU_SEL), 
		.ALU_OUT(ALU_OUT), 
		.CAR_FLAG(CAR_FLAG)
	);
	
	
	//Clock generation
	initial
	begin
	CLK = 1'b0;
	forever #5 CLK = ~CLK;
	end
	
	
	//Test-cases
	initial
	begin
	//Reset test case
	RST = 1'b1;
	$display("---Reset test case---");
	#10
	if(ALU_OUT != 16'b0 && CAR_FLAG != 1'b0)
	$display("---Reset test failed---");
	else
	$display("---Reset test passed---");
	RST = 1'b0;
	#10;
	
	
	//Addition test case
	ALU_SEL = 4'b0000;
	$display("---Addition test cases---");
	//Simple addition
	A = 8'd30;B = 8'd22;#10;
	if(ALU_OUT[7:0] != 8'd52 && CAR_FLAG != 1'b0)
	$display("---Addition test failed---");
	else
	$display("---Addition test passed---");
	//Over flow addition
	A = 8'hFF;B = 8'hFF;#10;
	if(ALU_OUT[7:0] != 8'd52 && CAR_FLAG != 1'b1)
	$display("---Addition test failed---");
	else
	$display("---Addition test passed---");
	//Addition with zero
	A = 8'hCC;B = 8'b0;#10;
	if(ALU_OUT[7:0] != 8'hCC && CAR_FLAG != 1'b0)
	$display("---Addition test failed---");
	else
	$display("---Addition test passed---");
	//Over flow addition
	A = 8'hAA;B = 8'hBB;#10;
	if(ALU_OUT[7:0] != 8'b01100101 && CAR_FLAG != 1'b1)
	$display("---Addition test failed---");
	else
	$display("---Addition test passed---");
	
	
	//Subtraction test case
	ALU_SEL = 4'b0001;
	$display("---Subtraction test cases---");
	//Two numbers A>B
	A = 8'd210;B = 8'd129;#10;
	if(ALU_OUT[7:0] != 8'd81)
	$display("---Subtraction test failed---");
	else
	$display("---Subtraction test passed---");
	//Subtract with zero
	A = 8'd196;B = 8'd0;#10;
	if(ALU_OUT[7:0] != 8'd196)
	$display("---Subtraction test failed---");
	else
	$display("---Subtraction test passed---");
	//Two numbers A<B
	A = 8'hAA;B = 8'hBB;#10;
	if(ALU_OUT[7:0] != 8'b00010001)
	$display("---Subtraction test failed---");
	else
	$display("---Subtraction test passed---");
	//Two numbers A<B
	A = 8'd34;B = 8'd99;#10;
	if(ALU_OUT[7:0] != 8'b01000001)
	$display("---Subtraction test failed---");
	else
	$display("---Subtraction test passed---");
	
	
	//Multiplication test cases
	ALU_SEL = 4'b0010;
	$display("---Multiplication test cases---");
	//Multiply two small numbers
	A = 8'h0F;B = 8'h0C;#10;
	if(ALU_OUT != 16'd180)
	$display("---Multiplication test failed---");
	else
	$display("---Multiplication test passed---");
	//Multiply by 1
	A = 8'd175;B = 8'd1;#10;
	if(ALU_OUT != 16'd175)
	$display("---Multiplication test failed---");
	else
	$display("---Multiplication test passed---");
	//Multiply by 0
	A = 8'd222;B = 8'd0;#10;
	if(ALU_OUT != 16'd0)
	$display("---Multiplication test failed---");
	else
	$display("---Multiplication test passed---");
	//Multiply large numbers
	A = 8'hFF;B = 8'hFF;#10;
	if(ALU_OUT != 16'd65025)
	$display("---Multiplication test failed---");
	else
	$display("---Multiplication test passed---");
	
	
	//Division test cases
	ALU_SEL = 4'b0011;
	$display("---Division test cases---");
	//A > B
	A = 8'd254;B= 8'd127;#10;
	if(ALU_OUT[7:0] != 8'd2)
	$display("---Division test failed---");
	else
	$display("---Division test passed---");
	//Divide A by 1
	A = 8'd230;B = 8'd1;#10;
	if(ALU_OUT[7:0] != 8'd230)
	$display("---Division test failed---");
	else
	$display("---Division test passed---");
	//Divide A by 0
	A = 8'd213;B = 8'b0;#10;
	if(ALU_OUT[7:0] != 8'bxxxxxxxx)
	$display("---Division test failed---");
	else
	$display("---Division test passed---");
	
	
	//Modulo division
	ALU_SEL = 4'b0100;
	$display("---Modulo division test cases---");
	//MD = 0
	A = 8'd240;B = 8'd15;#10;
	if(ALU_OUT[7:0] != 8'b0)
	$display("---Modulo Division test failed---");
	else
	$display("---Modulo Division test passed---");
	//MD != 0
	A = 8'd247;B = 8'd200;#10;
	if(ALU_OUT[7:0] != 8'd47)
	$display("---Modulo Division test failed---");
	else
	$display("---Modulo Division test passed---");
	//Mod div A by 0
	A = 8'd78;B = 8'd0;#10;
	if(ALU_OUT[7:0] != 8'dxxxxxxxx)
	$display("---Modulo Division test failed---");
	else
	$display("---Modulo Division test passed---");
	//Mod div = 0
	A = 8'd4;B = 8'd2;#10;
	if(ALU_OUT[7:0] != 8'd0)
	$display("---Modulo Division test failed---");
	else
	$display("---Modulo Division test passed---");
	
	
	//Bitwise and
	ALU_SEL = 4'b0101;
	$display("---Bitwise And test cases---");
	A = 8'b01010101;B = 8'b01010101;#10;
	if(ALU_OUT[7:0] != 8'b01010101)
	$display("---Bitwise and test failed---");
	else
	$display("---Bitwise and test passed---");
	A = 8'b11111111;B = 8'b0;#10;
	if(ALU_OUT[7:0] != 8'b0)
	$display("---Bitwise and test failed---");
	else
	$display("---Bitwise and test passed---");
	A = 8'b11111010;B = 8'b11110000;#10;
	if(ALU_OUT[7:0] != 8'b11110000)
	$display("---Bitwise and test failed---");
	else
	$display("---Bitwise and test passed---");
	A = 8'b1;B = 8'b1;#10;
	if(ALU_OUT[7:0] != 8'b1)
	$display("---Bitwise and test failed---");
	else
	$display("---Bitwise and test passed---");
	
	
	//Bitwise or
	ALU_SEL = 4'b0110;
	$display("---Bitwise Or test cases---");
	A = 8'b01010101;B = 8'b01010101;#10;
	if(ALU_OUT[7:0] != 8'b01010101)
	$display("---Bitwise Or test failed---");
	else
	$display("---Bitwise Or test passed---");
	A = 8'b11111111;B = 8'b0;#10;
	if(ALU_OUT[7:0] != 8'b11111111)
	$display("---Bitwise Or test failed---");
	else
	$display("---Bitwise Or test passed---");
	A = 8'b11111010;B = 8'b11110000;#10;
	if(ALU_OUT[7:0] != 8'b11111010)
	$display("---Bitwise Or test failed---");
	else
	$display("---Bitwise Or test passed---");
	A = 8'b10101010;B = 8'b10101010;#10;
	if(ALU_OUT[7:0] != 8'b10101010)
	$display("---Bitwise Or test failed---");
	else
	$display("---Bitwise Or test passed---");
	
	
	//Bitwise Xor
	ALU_SEL = 4'b0111;
	$display("---Bitwise Xor test cases---");
	A = 8'b01010101;B = 8'b01010101;#10;
	if(ALU_OUT[7:0] != 8'b0)
	$display("---Bitwise Xor test failed---");
	else
	$display("---Bitwise Xor test passed---");
	A = 8'b11111111;B = 8'b0;#10;
	if(ALU_OUT[7:0] != 8'b11111111)
	$display("---Bitwise Xor test failed---");
	else
	$display("---Bitwise Xor test passed---");
	A = 8'b11111010;B = 8'b11110000;#10;
	if(ALU_OUT[7:0] != 8'b00001010)
	$display("---Bitwise Xor test failed---");
	else
	$display("---Bitwise Xor test passed---");
	A = 8'b11111111;B = 8'b11111111;#10;
	if(ALU_OUT[7:0] != 8'b0)
	$display("---Bitwise Xor test failed---");
	else
	$display("---Bitwise Xor test passed---");
	
	
	//1's Complement
	ALU_SEL = 4'b1000;
	$display("---1's Complement test cases---");
	A = 8'b0;#10;
	if(ALU_OUT[7:0] != 8'b11111111)
	$display("---1's Complement test failed---");
	else
	$display("---1's Complement test passed---");
	A = 8'b11111111;#10;
	if(ALU_OUT[7:0] != 8'b0)
	$display("---1's Complement test failed---");
	else
	$display("---1's Complement test passed---");
	A = 8'b11001100;#10;
	if(ALU_OUT[7:0] != 8'b00110011)
	$display("---1's Complement test failed---");
	else
	$display("---1's Complement test passed---");
	A = 8'b01010101;#10;
	if(ALU_OUT[7:0] != 8'b10101010)
	$display("---1's Complement test failed---");
	else
	$display("---1's Complement test passed---");
	
	
	//2's Complement
	ALU_SEL = 4'b1001;
	$display("---2's Complement test cases---");
	A = 8'b0;#10;
	if(ALU_OUT[7:0] != 8'b0 && CAR_FLAG != 1'b1)
	$display("---2's Complement test failed---");
	else
	$display("---2's Complement test passed---");
	A = 8'b11111111;#10;
	if(ALU_OUT[7:0] != 8'b00000001 && CAR_FLAG != 1'b0)
	$display("---2's Complement test failed---");
	else
	$display("---2's Complement test passed---");
	A = 8'b11001100;#10;
	if(ALU_OUT[7:0] != 8'b00110100 && CAR_FLAG != 1'b0)
	$display("---2's Complement test failed---");
	else
	$display("---2's Complement test passed---");
	A = 8'b01010101;#10;
	if(ALU_OUT[7:0] != 8'b10101011 && CAR_FLAG != 1'b0)
	$display("---2's Complement test failed---");
	else
	$display("---2's Complement test passed---");
	
	
	//Relational operators
	ALU_SEL = 4'b1010;
	$display("---Relational Operator's test cases---");
	//A=B
	A = 8'd126;B = 8'd126;#10;
	if(ALU_OUT[0]!=1'b1)
	$display("---Relational Operator '=' test failed---");
	else 
	$display("---Relational Operator '=' test passed---");
	//A>B
	A = 8'd126;B = 8'd120;#10;
	if(ALU_OUT[2]!=1'b1)
	$display("---Relational Operator '>' test failed---");
	else 
	$display("---Relational Operator '>' test passed---");
	//A<B
	A = 8'd141;B = 8'd181;#10;
	if(ALU_OUT[1]!=1'b1)
	$display("---Relational Operator '<' test failed---");
	else 
	$display("---Relational Operator '<' test passed---");
	//A=B
	A = 8'd0;B = 8'd0;#10;
	if(ALU_OUT[0]!=1'b1)
	$display("---Relational Operator '=' test failed---");
	else 
	$display("---Relational Operator '=' test passed---");
	
	
	//Right Shift
	ALU_SEL = 4'b1011;
	$display("---Rightshift test cases---");
	A = 8'b11111111;#10;
	if(ALU_OUT[7:0] != 8'b01111111)
	$display("---Rightshift test failed---");
	else 
	$display("---Rightshift test passed---");
	A = 8'b0;#10;
	if(ALU_OUT[7:0] != 8'b0)
	$display("---Rightshift test failed---");
	else 
	$display("---Rightshift test passed---");
	A = 8'b10101010;#10;
	if(ALU_OUT[7:0] != 8'b01010101)
	$display("---Rightshift test failed---");
	else 
	$display("---Rightshift test passed---");
	A = 8'b11001100;#10;
	if(ALU_OUT[7:0] != 8'b01100110)
	$display("---Rightshift test failed---");
	else 
	$display("---Rightshift test passed---");
	
	
	//Leftshift
	ALU_SEL = 4'b1100;
	$display("---Leftshift test cases---");
	A = 8'b11111111;#10;
	if(ALU_OUT[7:0] != 8'b11111110)
	$display("---Leftshift test failed---");
	else 
	$display("---Leftshift test passed---");
	A = 8'b0;#10;
	if(ALU_OUT[7:0] != 8'b0)
	$display("---Leftshift test failed---");
	else 
	$display("---Leftshift test passed---");
	A = 8'b10101010;#10;
	if(ALU_OUT[7:0] != 8'b01010100)
	$display("---Leftshift test failed---");
	else 
	$display("---Leftshift test passed---");
	A = 8'b11001100;#10;
	if(ALU_OUT[7:0] != 8'b10011000)
	$display("---Leftshift test failed---");
	else 
	$display("---Leftshift test passed---");
	
	
	//Concatenate B and A 
	ALU_SEL = 4'b1101;
	$display("---Concatenate B and A test cases---");
	A = 8'b0;B = 8'b11111111;#10;
	if(ALU_OUT != 16'hFF00)
	$display("---Concatenate B and A failed---");
	else 
	$display("---Concatenate B and A passed---");
	A = 8'b10101010;B = 8'b11001100;#10;
	if(ALU_OUT != 16'b1100110010101010)
	$display("---Concatenate B and A failed---");
	else 
	$display("---Concatenate B and A passed---");
	A = 8'b0;B = 8'b11111111;#10;
	if(ALU_OUT != 16'hFF00)
	$display("---Concatenate B and A failed---");
	else 
	$display("---Concatenate B and A passed---");
	A = 8'hFF;B = 8'hFF;#10;
	if(ALU_OUT != 16'hFFFF)
	$display("---Concatenate B and A failed---");
	else 
	$display("---Concatenate B and A passed---");
	
	
	//Concatenate A and B 
	ALU_SEL = 4'b1110;
	$display("---Concatenate A and B test cases---");
	A = 8'b0;B = 8'b11111111;#10;
	if(ALU_OUT != 16'h00FF)
	$display("---Concatenate A and B failed---");
	else 
	$display("---Concatenate A and B passed---");
	A = 8'b10101010;B = 8'b11001100;#10;
	if(ALU_OUT != 16'b1010101011001100)
	$display("---Concatenate A and B failed---");
	else 
	$display("---Concatenate A and B passed---");
	A = 8'b0;B = 8'b11111111;#10;
	if(ALU_OUT != 16'h00FF)
	$display("---Concatenate A and B failed---");
	else 
	$display("---Concatenate A and B passed---");
	A = 8'hFF;B = 8'hFF;#10;
	if(ALU_OUT != 16'hFFFF)
	$display("---Concatenate A and B failed---");
	else 
	$display("---Concatenate A and B passed---");
	
	
	//A + A
	ALU_SEL = 4'b1111;
	$display("---A + A---");
	A = 8'b11111111;#10;
	if(ALU_OUT[7:0] != 8'b11111110 && CAR_FLAG != 1'b1)
	$display("---A + A test failed---");
	else 
	$display("---A + A test passed---");
	A = 8'b0;#10;
	if(ALU_OUT[7:0] != 8'b0 && CAR_FLAG != 1'b0)
	$display("---A + A test failed---");
	else 
	$display("---A + A test passed---");
	A = 8'hCC;#10;
	if(ALU_OUT[7:0] != 8'b10011000 && CAR_FLAG != 1'b1)
	$display("---A + A test failed---");
	else 
	$display("---A + A test passed---");
	A = 8'hAB;#10;
	if(ALU_OUT[7:0] != 8'b01010110 && CAR_FLAG != 1'b1)
	$display("---A + A test failed---");
	else 
	$display("---A + A test passed---");
	
	
	$finish;
	end   
endmodule

