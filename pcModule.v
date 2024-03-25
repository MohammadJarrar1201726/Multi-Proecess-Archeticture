
// PC register and its logic
// PC src can be one of the following:
//1 - PC + 4
// 2- Branch (PC + Imm)	 (if instruction is I-type and true Branch BEQ and BNE and BGT and BLT)
// 3- jump target address (	PC// Imm) in JMP and CALL
// 4 - PC = top of the stack   (RET )
module pcModule(clock , PC, I_TypeImmediate , J_TypeImmediate , returnAddress , pcSrc_control);
	// ---------------INPUTS -----------
	// clock 
	input wire clock;
	
	// PC source control
	input wire [1:0] pcSrc_control;
	
	
	//stack poped return address but
	input wire [31 :0 ] returnAddress;
	
	// extended I-type immediate bus
	
	input wire [31:0] I_TypeImmediate;

	// J-Type immediate bus
	input wire signed [25:0] J_TypeImmediate;
	
	//---------OUTPUTS----------------------
	// PC
	output reg [31:0] PC;
	//------------------INTERNALS----------
	
	//PC+4
	wire [31:0] pc_plus_4;
	
	// JTA					  
	wire [31:0] jump_target_address;
	
	//BTA
	wire [31:0] branch_target_address;
	
	assign pc_plus_4 = PC + 32'd1;
	assign jump_target_address = {PC[31:26] ,J_TypeImmediate };
	assign branch_target_address= PC+ I_TypeImmediate;
	
	
	initial begin
		PC <= 32'd0;
	end
	always @(posedge clock) begin 
		$display("PC=%0d", PC);
		
		case(pcSrc_control)	 
			PC_Src_Dft: begin
				// PC = PC+4
				PC <= pc_plus_4;
			end
			PC_Src_BTA: begin
				// return PC= PC + ext(Imm16)
				PC <= branch_target_address;
			end
			PC_Src_JMP: begin
				// return PC = {PC[31:26] , Imm26} 
				PC <= jump_target_address;	
			end								
			PC_Src_Ra: begin
				// PC = top of the stack
				PC <= returnAddress;	 
			end
		endcase
	end
	
endmodule

