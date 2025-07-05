`timescale 1ns / 1ps
module alu_8bit(CLK,RST,A,B,ALU_SEL,ALU_OUT,CAR_FLAG);
//Inputs
input [7:0]A;
input [7:0]B;
input [3:0]ALU_SEL;
input RST;
input CLK;
//Outputs
output reg [15:0]ALU_OUT;
output reg CAR_FLAG;//For Carry
//Code starts
initial begin
		$display(" LIST OF OPERATIONS\n 0.Addition\n 1.Subtraction\n 2.Multiplication\n 3.Division\n 4.Modulo Division\n 5.Bitwise and\n 6.Bitwise or\n 7.Bitwise xor\n 8.1's Complement\n 9.2's Complement\n 10.Relational Operators\n 11.Right Shift\n 12.Left Shift\n 13.Concatenate B and A\n 14.Concatenate A and B\n 15.A + A\n");
end
always@(posedge CLK)
begin
	if(RST == 1)
		begin
			ALU_OUT = 16'b0;
			CAR_FLAG = 1'b0; 
			$display("Reset has been activated.\n");
		end
	else
		begin
			case(ALU_SEL)
				4'b0000:/*Addition - Performing on A and B of 8 bits, designed in such a
							way that if result exceeds then carry flag gets set, so the 
							9th bit of alu-ouput decides the carry flag.*/
							begin
							$display("Addition\n");
							ALU_OUT = A+B;
							CAR_FLAG = ALU_OUT[8];
							$display("Addition of %d and %d is:%d.\n",A,B,ALU_OUT);
							if(CAR_FLAG)
							begin
							$display("Carry bit set, result exceeds the 8-bit range.");
							end
							end
				4'b0001:/*Subtraction - Performing on A and B (only A - B),So when A > B then
							simply A - B is result(for A = B also) if not then the 2's comp of B is added to A 
							*/
							begin
							CAR_FLAG = 1'b0;
							if(B>A)
							begin
							ALU_OUT[7:0] = A - B;
							ALU_OUT[7:0] = (~ALU_OUT[7:0]) + 8'b1;
							ALU_OUT[15:8] = 8'b0;
							$display("Subtraction of %d and %d is: -%d.\n",A,B,ALU_OUT);
							end
							else
							begin
							ALU_OUT[7:0] = A - B;
							ALU_OUT[15:8] = 8'b0;
							$display("Subtraction of %d and %d is:%d.\n",A,B,ALU_OUT);
							end
							end
				4'b0010:/*Multiplication - Performed A * B*/
							begin
							ALU_OUT = A*B;
							CAR_FLAG = 1'b0;
							$display("Mulltiplication of %d and %d is:%d",A,B,ALU_OUT);
							end
				4'b0011://Division - Always performining only A / B only
							begin
							CAR_FLAG = 1'b0;
							ALU_OUT[15:8] = 8'b0;
							if(B==8'b0)
							begin
							$display("Invalid");
							ALU_OUT[7:0] = 8'bxxxxxxxx;
							end
							else
							begin
							ALU_OUT[7:0] = A/B;
							$display("DIvison %d/%d is:%d.",A,B,ALU_OUT);
							end
							end
				4'b0100://Modulo Division
							begin
							CAR_FLAG = 1'b0;
							ALU_OUT[15:8] = 8'b0;
							//Always Always performining only A / B only
							if(A>=B)
							begin
							ALU_OUT[7:0] = A%B;
							$display("Remainder of %d/%d is:%d.",A,B,ALU_OUT);
							end
							else
							begin
							$display("Invalid");
							ALU_OUT[7:0] = 8'bxxxxxxxx;
							end
							end
				4'b0101://Bitwise and
							begin
							ALU_OUT[7:0] = A & B;
							ALU_OUT[15:8] = 8'b0;
							CAR_FLAG = 1'b0;
							$display("%b AND %b is:%b",A,B,ALU_OUT[7:0]);
							end
				4'b0110://Bitwise or
							begin
							ALU_OUT[7:0] = A | B;
							ALU_OUT[15:8] = 8'b0;
							CAR_FLAG = 1'b0;
							$display("%b OR %b is:%b",A,B,ALU_OUT[7:0]);
							end
				4'b0111://Bitwise xor
							begin
							ALU_OUT[7:0] = A ^ B;
							ALU_OUT[15:8] = 8'b0;
							CAR_FLAG = 1'b0;
							$display("%b XOR %b is:%b",A,B,ALU_OUT[7:0]);
							end
				4'b1000://1's Complement only for A
							begin
							ALU_OUT[7:0] = ~A;
							ALU_OUT[15:8] = 8'b0;
							CAR_FLAG = 1'b0;
							$display("1'Complement of %b is:%b",A,ALU_OUT[7:0]);
							end
				4'b1001:/*2's Complement only for A i.e 1's Complement + 1'b1 it will be
							okay untill result does not exceeds 8 bit range, if exceeds then
							CAR_FLAG set.*/
							begin
							ALU_OUT = {7'b0,({1'b0,~A} + 9'b000000001)}; 
							CAR_FLAG = ALU_OUT[8];
							$display("2'Complement of %b is:%b",A,ALU_OUT[7:0]);
							if(CAR_FLAG)
							begin
							$display("Carry bit set, result exceeds the 8-bit range.");
							end
							end
				4'b1010:/*Relational Operators - When A is greater then B the ALU_OUT's 3rd bit
							is going to be active indicating the condition true similarly for B greater that A
							or A less then B ALU_OUT's 2nd bit is going to be active if not both the A = B which is 
							represented by ALU_OUT's 1st bit.*/
							begin
							ALU_OUT = 16'b0;
							CAR_FLAG = 1'b0; 
							if(A>B)
							begin
							ALU_OUT[2]=1'b1;
							$display("A is greter then B i.e %d > %d.",A,B);
							end
							else if(A<B)
							begin
							ALU_OUT[1]=1'b1;
							$display("B is greter then A i.e %d > %d.",B,A);
							end
							else
							begin
							ALU_OUT[0]=1'b1;
							$display("A is equal to B i.e %d = %d.",A,B);
							end
							end
				4'b1011://Right Shift - Performed on A only by 1 bit.
							begin
							ALU_OUT[7:0] = A >> 1'b1;
							ALU_OUT[15:8] = 8'b0;
							CAR_FLAG = 1'b0;
							$display("%b after right shift by 1 bit:%b",A,ALU_OUT[7:0]);
							end
				4'b1100://Left Shift - Performed on A only by 1 bit.
							begin
							ALU_OUT[7:0] = A << 1'b1;
							ALU_OUT[15:8] = 8'b0;
							CAR_FLAG = 1'b0;
							$display("%b after left shift by 1 bit:%b",A,ALU_OUT[7:0]);
							end
				4'b1101://Concatenate B and A 
							begin
							ALU_OUT = {B,A};
							CAR_FLAG = 1'b0;
							$display("Concatenation of B and A is:%b",ALU_OUT);
							end
				4'b1110://Concatenate A and B
							begin
							ALU_OUT = {A,B};
							CAR_FLAG = 1'b0;
							$display("Concatenation of A and B is:%b",ALU_OUT);
							end
				4'b1111://A + A 
							begin
							ALU_OUT = A + A;
							CAR_FLAG = ALU_OUT[8];
							ALU_OUT[15:9] = 7'b0;
							$display("A + A = %b",ALU_OUT);
							if(CAR_FLAG)
							begin
							$display("Carry bit set, result exceeds the 8-bit range.");
							end
							end
				default://Default case
							begin
							ALU_OUT = 16'hFFFF;
							$display("Invalid Option.");
							end
			endcase
		end
end
endmodule
