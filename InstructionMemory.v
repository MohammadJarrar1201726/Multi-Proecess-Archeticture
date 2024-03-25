
module instructionMemory(clock , addressBus, instructionReg);
	
	// -------INPUTS --------
	
	//clock
	input wire clock;
	
	// address bus
	input wire [31:0] addressBus;
	
	//----------OUTPUTS --------
	
	//instruction register
	
	output reg [0:31] instructionReg;
	
	// -----------INTERNALS -------
	
	//instruction memory
	reg [31:0] instruction_memory [0:255];	
	
	assign instructionReg= instruction_memory[addressBus[31:0]];
	
	// --------------------LOGIC -------
	
	
	
	
	
	// ---------------INITIALIZATION
	
	initial begin
		// load instructions from file
		
	
	  
		
		
	//--------- Loop Program ------------
		/*
	instruction_memory[1] = {ADDI , R1 , R0 , 16'b1 , 2'b00};
	instruction_memory[2] = {ADDI , R2 , R0 , 16'b10 , 2'b00};
	instruction_memory[3] = {PUSH , R1 , 22'd0}; 	
	instruction_memory[4] = {PUSH , R2 , 22'd0};   
	instruction_memory[5] = {RET , R1 , 22'd0};	
	 
	*/	  	  
	
	/*
	//Program 1
	
	instruction_memory[1] = {ADDI , R1 , R0 , 16'd7 , 2'b00};
	instruction_memory[2] = {ADDI , R2 , R0 , 16'd8 , 2'b00};
	instruction_memory[3] = {ADDI , R3 , R0 , 16'd2 , 2'b00};
	instruction_memory[4] = {SW , R1 , R3 , 16'd5 , 2'b00};
	instruction_memory[5] = {LW , R1 , R3 , 16'd5 , 2'b00};
	
	ADDI R1,R0,7;
	ADDI R2,R0,8;
	ADDI R3,R0,2;
	SW R1,5(R3);
	LW R1,5(R3);
	*/
	
	
	
	//Program 2
	instruction_memory[1] = {ADDI , R1 , R0 , 16'd2 , 2'b00};
	instruction_memory[2] = {ADDI , R2 , R0, 16'd3 , 2'b00};
	instruction_memory[3] = {BGT , R1 , R2 , 16'd2 , 2'b00};
	instruction_memory[4] = {SUB , R3 , R2 , R1 , 14'b0};
	instruction_memory[5] = {JMP , 26'd7};
	instruction_memory[6] = {SUB , R3 , R1 , R2 , 14'b0};
	instruction_memory[7] = {CALL , 26'd10};	
	instruction_memory[8] = {SW , R7 , R10, 16'd7 , 2'b00 };
	instruction_memory[10] = {ADDI , R8 , R0 , 16'b1011 , 2'b00};
	instruction_memory[11] = {ADDI , R9 , R0 , 16'b1100 , 2'b00};
	instruction_memory[12] = {AND , R7 , R8 , R9 , 14'd0};
	instruction_memory[13] = {RET , 26'd0};
	/*
	ADDI R1,R0,2;
	ADDI R2,R0,3;
	BGT R1,R2,label;
	SUB R3,R2,R1;
	JMP 7; 
	SUB R3,R1,R2;
	CALL 10;
	SW R7,7(R10);
	10:
	ADDI R8,R0,1011;
	ADDI R8,R0,1100;
	AND R7,R8,R9;
	RET
	*/
	
	
	
	  /*
	
	//Program3
	
	instruction_memory[1] = {ADDI , R1 , R0 , 16'd19 , 2'b00};
	instruction_memory[2] = {ADDI , R2 , R0 , 16'd10 , 2'b00};
	instruction_memory[3] = {PUSH , R1 , 22'd0};
	instruction_memory[4] = {SW , R1 , R2 , 16'd5 , 2'b00};
	instruction_memory[5] = {LWPOI , R1 , R2 , 16'd5 , 2'b00};
	instruction_memory[6] = {ADDI , R2 , R2 , 16'd1 , 2'b00}; 
	instruction_memory[7]= {POP , R7 , 22'd0}; 
	
	*/
	/*
	ADDI R1,R0 , 19;
	ADDI R2,R0 , 10;
	PUSH R1;
	SW R1 , 5(R2);
	LWPOI R1, 5(R2);
	ADDI R2 ,R2, 1;
	POP R7;
	*/
	
	
	
	
	

	

	end   
	   
endmodule