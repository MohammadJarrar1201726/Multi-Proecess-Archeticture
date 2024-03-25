parameter

// levels

LOW = 1'b0,
HIGH = 1'b1,

//instruction opcode
// 6 bit instruction opcode


// R-Type Instructions

	AND = 6'b000000, //Reg(Rd) = Reg(Rs1) & Reg(Rs2) 
	ADD = 6'b000001, //Reg(Rd) = Reg(Rs1) + Reg(Rs2) 
	SUB = 6'b000010, //Reg(Rd) = Reg(Rs1) - Reg(Rs2)
	
	//I- Type Instructions 
	
	ANDI = 6'b000011,   //Reg(Rd) = Reg(Rs1) & Imm16	
	ADDI = 6'b000100,	//Reg(Rd) = Reg(Rs1) + Imm16
	LW  = 6'b000101, // Reg(Rd) = Mem(Reg(Rs1) + Imm16 )
	LWPOI =  6'b000110, // Reg(Rd) = Mem(Reg(Rs1) + Imm16);Reg[Rs1] = Reg[Rs1] + 1	
	SW  = 6'b000111,	// Mem(Reg(Rs1) + Imm16) = Reg(Rd)
	BGT = 6'b001000,  //if (Reg(Rd) > Reg(Rs1)) Next PC = PC + sign_extended (Imm16);else PC = PC + 1									
	BLT =  6'b001001, //  if (Reg(Rd) < Reg(Rs1)) Next PC = PC + sign_extended (Imm16);else PC = PC + 1			 
	BEQ = 6'b001010, //		 if (Reg(Rd) == Reg(Rs1))  Next PC = PC + sign_extended (Imm16);else PC = PC + 1
	BNE =  6'b001011, //if (Reg(Rd) != Reg(Rs1)) Next PC = PC + sign_extended (Imm16);else PC = PC + 1					   
	
	// J- Type Instructions
	JMP = 6'b001100, //  Next PC = {PC[31:26], Immediate26 } 
	CALL = 6'b001101, // Next PC = {PC[31:26], Immediate26 } ;PC + 1 is pushed on the stack	 
	RET =  6'b001110, //Next PC = top of the stack
	
	//S-Type Instructions
	PUSH = 6'b001111, //  Rd is pushed on the top of the stack
	POP = 6'b010000, //	The top element of the stack is popped,and it is stored in the Rd register 
	
// ALU function code signal
// 2-bit chip select for ALU
	
	ALU_ADD = 2'b00,// ADD , ADDI , LW , LWPOI
	ALU_Sub = 2'b01, //used in SUB , BEQ , BGT , BLT , BNE 
	ALU_And = 2'b10, //used for AND , ANDI
		
		
// stack pointer values
PUSH_VALUE = 2'b00,
POP_VALUE = 2'b01,
OTHER_VALUE = 2'b10,

		
// PC source signal
// 2-bit source select for next PC value
	
	PC_Src_Dft = 2'b00,// PC = PC +4  
	PC_Src_BTA = 2'b01, // BTA (PC + Imm16)	  
	PC_Src_JMP = 2'b10, // Jump address
	PC_Src_Ra = 2'b11,// return address from stack

// Mode values signal
// 2-bit for select the value written of Rs1
	Mode_All = 2'b00,
	Mode_LWPOI = 2'b01,
	
//32 registers
R0 = 4'd0, // general purpose register	
R1 = 4'd1, 	 // general purpose register	
R2 = 4'd2, // general purpose register
R3 = 4'd3, // general purpose register
R4 = 4'd4, // general purpose register
R5 = 4'd5, // general purpose register
R6 = 4'd6, // general purpose register
R7 = 4'd7, // general purpose register
R8 = 4'd8, // general purpose register
R9 = 4'd9, // general purpose register
R10 = 4'd10, // general purpose register
R11 = 4'd11, // general purpose register
R12 = 4'd12, // general purpose register
R13 = 4'd13, // general purpose register
R14 = 4'd14, // general purpose register
R15 = 4'd15; // general purpose register
	