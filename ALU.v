module ALU(clock , A , B , Output , flag_zero , flag_negative, flag_overflow , sig_alu_op);
	
	// ------------- Signals and Inputs ---------------
	
	// clock
	input wire clock;
	
	// chip select for ALU operation
		
		input wire [1:0] sig_alu_op;
		
		//operands
		input wire [31:0] A, B;
		
		// ---------------Outputs ---------------
		
		output reg [31:0] Output;
		output reg flag_zero;
		output reg flag_negative;
		output reg flag_overflow;
		wire  flag_carry ;
		
		    // Logic to detect overflow during addition or subtraction

	assign flag_zero = (0 == Output);
	assign flag_negative = (Output[31] == 1); // if 2s complement number is negative , MSB equals to 1
	 // Logic to detect overflow during addition or subtraction
		
	wire sum;
	assign {flag_carry, sum} = A + B;
	
	always @(posedge clock) begin
		 // wait for ALU source mux to select operands 
		 #1ns  
		case(sig_alu_op)
			ALU_ADD:begin
			Output <= A+B;   		  		   
			end
			ALU_Sub:begin
			Output <= A- B;
			flag_overflow <=  ((A[31] & ~B[31] & ~Output[31]) | (~A[31] & B[31] & Output[31]));; //find overflow flag		   
			end
			ALU_And: begin 
			Output <= A &B ; 
			end
			default : Output <=0;  
			
			
		endcase		
			#1ns
		$display("ALU:A=%0d , B= %0d , ALU_Output = %0d", A , B, Output);  
		#1ns
		$display("ALU:zero_flag= %0d ,overflow_flag = %0d , negative_flag=%0d" , flag_zero, flag_overflow, flag_negative);
	
	end
endmodule

