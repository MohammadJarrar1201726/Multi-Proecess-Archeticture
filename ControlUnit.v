module ControlUnit(
	clock,	  
	
	alu_op,
	pc_src,
	alu_src,
	reg_src,   
	ext_op,
	 
	
	enable_data_memory_write,
	enable_data_memory_read,
	DataT,
	
	SM,
	stack_value,
	write_back_data_select1,	
	write_back_data_select2,
	
	rf_enable_write1,
	rf_enable_write2,
	
	
	//stage enable outputs
	en_instruction_fetch,
	en_instruction_decode,
	en_execute,
	
	
	//intputs
	
	
	FunctionCode,
	flag_zero,
	flag_overflow,
	flag_negative
	
	
	
	
);



//--------INPUTS ------------

//clock
input wire clock;



//function code
input wire [5:0] FunctionCode;	 

// Mode Bits
//input wire [1:0] ModeBits;

//flags
input wire flag_zero;
input wire flag_overflow;
input wire flag_negative;



//-----------OUTPUTS----------

//Mux signals	 

output reg [1:0] alu_op;
output reg [1:0] pc_src = PC_Src_Dft;
output reg  alu_src;	
output reg [1:0] stack_value;


output reg reg_src , write_back_data_select1 , write_back_data_select2  , ext_op ;

// operation enable signals
output reg rf_enable_write1 = LOW,
rf_enable_write2 = LOW,
enable_data_memory_write =LOW,
enable_data_memory_read =LOW, 
DataT = LOW,
SM = HIGH ;



//stage enable signals
output reg en_execute = LOW , 
en_instruction_fetch = LOW,
en_instruction_decode = LOW;


// ----------- INTERNALS --------

// encode the stages

`define STAGE_FTCH 3'b000
`define STAGE_DCDE 3'b001
`define STAGE_EXEC 3'b010
`define STAGE_MEM 3'b011
`define STAGE_WRB 3'b100
`define STAGE_INIT 3'b101 

reg [2:0] current_stage = `STAGE_INIT;
reg [2:0] next_stage = `STAGE_FTCH;


always @(posedge clock) begin
	
	current_stage= next_stage;
	
end			  

always @(posedge clock) begin  
	
	case(current_stage) 
		`STAGE_INIT: begin
			
			en_instruction_fetch = LOW; // fetch after find PC src
			next_stage <= `STAGE_FTCH;
		end
		`STAGE_FTCH: begin
			// disabe previous stage	
			next_stage <= `STAGE_DCDE;
			
			en_instruction_decode =LOW;
			en_execute = LOW;
			
			// disable the signals
			rf_enable_write1 =LOW;
			rf_enable_write2 = LOW;
			enable_data_memory_read = LOW;
			enable_data_memory_write = LOW;
			SM = LOW;	
			DataT = LOW;   
			stack_value <= OTHER_VALUE;
			
			// enable current stage
			en_instruction_fetch = HIGH; // fetch after find PC src
			// next stage
			
			
			// set control signals
			
			
		if(FunctionCode == JMP ||  FunctionCode == CALL)begin
			pc_src = PC_Src_JMP;
		end
		
		else if (FunctionCode == RET) begin
			
		end
		else if (((FunctionCode == BEQ && flag_zero)|| (FunctionCode == BNE && !flag_zero)  || (FunctionCode == BLT && ~flag_zero && flag_negative == flag_overflow) || (FunctionCode== BGT && flag_negative != flag_overflow  ) )) begin
			pc_src = PC_Src_BTA;
		end	
		
		else begin
			pc_src = PC_Src_Dft;
			
		end
		
	end				  
	
	`STAGE_DCDE: begin	
		//diable previous stage
		en_instruction_fetch = LOW;
		
		//enable current stage
		en_instruction_decode = HIGH;
		
		// next stage	   
		if( FunctionCode == JMP)begin
			
			next_stage <= `STAGE_FTCH;
			
		end	
		
	else if (FunctionCode == CALL || FunctionCode == PUSH || FunctionCode == POP || FunctionCode == RET) begin   
			next_stage <= `STAGE_MEM;
	end		
	
	else begin
		next_stage <= `STAGE_EXEC;
		
	end
		//next_stage <= ( FunctionCode == JMP )? `STAGE_FTCH : `STAGE_EXEC; 
		
		
		
		// set control signals
		reg_src = (FunctionCode == AND || FunctionCode == SUB || FunctionCode == ADD || FunctionCode ==  ANDI || FunctionCode == ADDI ) ? LOW : HIGH ;
		
		alu_src = (FunctionCode == AND || FunctionCode == SUB || FunctionCode == ADD || FunctionCode == BGT || FunctionCode == BLT || FunctionCode == BEQ || FunctionCode == BNE)? LOW : HIGH;
		
		ext_op = (FunctionCode == AND) ? LOW :HIGH;	 
		SM = (FunctionCode == PUSH || FunctionCode == POP || FunctionCode == CALL || FunctionCode == RET  ) ? LOW : HIGH;
		
		
		
		
	end	   
	
	`STAGE_EXEC: begin 
		
		// disable previous stage
		en_instruction_decode = LOW;
		
		// enable current stage
		
		en_execute = HIGH;
		
		// --------ALU Operation -------
	
	if(FunctionCode== BEQ || FunctionCode == BNE || FunctionCode == BGT || FunctionCode == BLT || FunctionCode ==SUB) begin 
		alu_op = ALU_Sub;
	
	end
	else if(FunctionCode == ANDI || FunctionCode == AND) begin
	   alu_op =ALU_And;
	   
	end	
	else begin 	
		alu_op = ALU_ADD;	
	end	
		
		// next stage
		
		if( FunctionCode == AND || FunctionCode == SUB || FunctionCode== ADD || FunctionCode == ADDI || FunctionCode == ANDI) begin	 
			next_stage <= `STAGE_WRB;
		
		end	
	else if (FunctionCode == BEQ || FunctionCode== BNE || FunctionCode == BLT || FunctionCode == BGT) begin
		next_stage <= `STAGE_FTCH;
		
	end	
	
	else   begin
		next_stage <=`STAGE_MEM;  
	end
	
		
	

		
	end	
	`STAGE_MEM: begin	
		
		// disable previous stage
			 
		DataT = (FunctionCode == CALL) ? HIGH : LOW;
		
		// next stage
		
		next_stage <= (FunctionCode == LW || FunctionCode == LWPOI || FunctionCode ==RET) ? `STAGE_WRB : `STAGE_FTCH;
		
		// Memory
		
		enable_data_memory_write = (FunctionCode == SW || FunctionCode ==PUSH || FunctionCode ==CALL)? HIGH : LOW;
		enable_data_memory_read = (FunctionCode == LW || FunctionCode == LWPOI || FunctionCode == RET || FunctionCode== POP) ? HIGH : LOW;	 
	
		
		if(FunctionCode == PUSH | FunctionCode == CALL ) begin
			stack_value <= PUSH_VALUE;
		end
	else if(FunctionCode == POP | FunctionCode == RET)begin
		stack_value <= POP_VALUE;
	end
	else begin
		stack_value <= OTHER_VALUE;
	end
	
	en_execute = LOW;
		
		
	end	 
	
	`STAGE_WRB: begin
		// disable previous stages	
		stack_value <= OTHER_VALUE;
		
		if(FunctionCode == RET)begin
				pc_src = PC_Src_Ra;
		end
		
		
		enable_data_memory_write = LOW;
		enable_data_memory_read = LOW;
		en_execute = LOW;
		
		SM = LOW;
		// next stage
		
		next_stage <= `STAGE_FTCH;
		

		// register file write enable
		rf_enable_write1 = (FunctionCode == RET) ? LOW:HIGH;  	 
		rf_enable_write2 = (FunctionCode == LWPOI) ? HIGH : LOW;
		
		// register file write enable 
		write_back_data_select1 = (FunctionCode == LW || FunctionCode == LWPOI | FunctionCode == RET | FunctionCode == POP)? HIGH : LOW;
		write_back_data_select2 = (FunctionCode == LWPOI ) ? HIGH : LOW;
		
		
		

		
	
	end
	
	
	
	
	endcase
		
	
end	


endmodule