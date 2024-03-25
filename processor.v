module processor();
	
	
	initial begin
		
	#0ns
	$display ("(%0t) > Initializing processor ... " , $time); 
		
	
	#300ns $finish;
	
	end
	
	//clock										
	
	wire clock;
	
	// -------------- Control Unit ----------
	
	// muxex signals
	wire [1:0] sig_alu_op;
	wire [1:0] sig_pc_src;
	wire sig_alu_src;  	
	wire [1:0] stack_value;
	
	
	wire sig_write_back_data_select1,
	sig_write_back_data_select2,
	sig_reg_src;
	
	// operation enable signal
	wire sig_rf_enable_write1,
	sig_rf_enable_write2,
	sig_enable_data_memeory_write = LOW  ,
	sig_enable_data_memeory_read = LOW ,  
	SM,
	DataT;
	
	
	// stage enable signals( used as clock for each stage)
		
		wire en_instruction_fetch,
		en_instruction_decode,
		en_execute;	
		
		
	//--------------Instruction Memory --------------
	
	// instruction memory
	
	wire [31:0] PC;// output of PC module input
	wire [0:31] IR;
	
	// Instruction Opcode
	wire [5:0] FunctionCode;
	
	//R-Type
	wire [3:0] Rd , Rs1 , Rs2;// register selection
	assign FunctionCode = IR[0:5];
	assign Rd = IR[6:9];
	assign Rs1 = IR[10:13];
	assign Rs2 = IR[14:17]; 
	
	// J-Type
	wire signed [0:25] J_TypeImmediate;
	assign J_TypeImmediate = IR[6:31];
	
	//I-Type
	wire signed [0:15] I_TypeImmediate;
	assign I_TypeImmediate = IR[14:29];	 
	
	wire [1:0]  ModeBits ;
	assign ModeBits = IR[30:31];
	
	//---------PC Modules ----------------
	
	//register file 
	reg [31:0] returnAddress; //input to PC module
	wire [31:0] Sign_Extended_I_TypeImmediate , Unsigned_Extended_I_TypeImmediate ;	
	
	// signed I_Type
	assign Sign_Extended_I_TypeImmediate =  { {16{I_TypeImmediate[0]}}, I_TypeImmediate }; 
	
	assign Unsigned_Extended_I_TypeImmediate = { {16{1'b0}}, I_TypeImmediate };		 
	
	
	

	
	// ----------------- Register File -----------------
	
	reg [31:0] BusW1, BusW2;
	wire [31:0] BusA , BusB;
	
	wire [3:0] RA, RB, RW;
	
	assign RA =   Rs1;
	
	assign RB = (sig_reg_src == LOW)? Rs2 :Rd;
	assign RW = Rd;	 
	
	wire ext_op;
	
	//---------------ALU--------------
	
	reg [31:0] ALU_A , ALU_B ; //operands
	wire [31:0] ALU_output;
	wire flag_zero;
	wire flag_negative;
	wire flag_overflow;
	
	assign ALU_A = BusA;
	
	always @(posedge en_execute) begin	
		
		if(!sig_alu_src)begin 
			ALU_B <=  BusB;
			
			
		end	   
	else begin 
		if(ext_op)begin	
		ALU_B <= Sign_Extended_I_TypeImmediate;
			
			
	end	
	else begin 
		ALU_B <= Unsigned_Extended_I_TypeImmediate;
	
	end
	
	end
		

		
	end	
	
	
	
	//----------Data Memory -------------
	
	wire [31:0] DataMemoryAddressBus;
	wire [31:0] DataMemoryInputBus;
	
	wire [31:0] DataMemoryOutputBus;   
	reg [31:0] stack_pointer;	
	
	initial begin
		stack_pointer = 224;
	end
	
	
	
	//CLOCK
	
	//generates clock square wave with 10ns period
	
	ClockGenerator clock_generator(clock);
	
	//ControlUnit
	
  ControlUnit control_unit(
	clock,
	sig_alu_op,
	sig_pc_src,
	sig_alu_src,
	sig_reg_src,   
	ext_op,
	 
	
	sig_enable_data_memory_write,
	sig_enable_data_memory_read,
	DataT,						 
	
	
	SM,
	stack_value,
	sig_write_back_data_select1,	
	sig_write_back_data_select2,
	
	sig_rf_enable_write1,
	sig_rf_enable_write2,
	
	
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

	wire flag_full , flag_empty;
	assign flag_full = (stack_pointer == 31'd255)? 1:0	 ;
	assign flag_empty = (stack_pointer == 31'd224)?	  1:0 ;
	
	always @ (stack_value , negedge sig_enable_data_memory_read) begin
		if(stack_value == PUSH_VALUE && !flag_full && sig_enable_data_memory_write )begin	
			stack_pointer = stack_pointer +1;
			
			
		end	  
		else if(stack_value == POP_VALUE && !flag_empty && !sig_enable_data_memory_read) begin
			  stack_pointer = stack_pointer-1;
		end	   
		
	end
	

	assign DataMemoryAddressBus =(SM == HIGH)? ALU_output:stack_pointer;
	assign DataMemoryInputBus =  (DataT == HIGH)? (PC+1):BusB;
	

	
	
	
	

// -------- Instruction Memeory-----

// use en_instruction_fetch as clock for instruction memroy
	instructionMemory instruction_mem(clock , PC ,IR);
	
	//PC Module	  
		always @(IR)begin	 
			$display("IR= 0x%0h",IR);
			
		end
	
		
	pcModule pc_module(en_instruction_fetch, PC , Sign_Extended_I_TypeImmediate , J_TypeImmediate , returnAddress , sig_pc_src);   
	
	
	// ----- Register file -----------
	
	
	registerFile register_file( en_instruction_decode, RA , RB ,RW , sig_rf_enable_write1, sig_rf_enable_write2 , BusW1 ,BusW2 , BusA , BusB);
	
	
	//-----ALU -----
	
	ALU alu(en_execute,  ALU_A , ALU_B , ALU_output, flag_zero, flag_negative, flag_overflow, sig_alu_op);	 
	
	
	//---Data Memory--------
	
	DataMemory data_memroy(clock , DataMemoryAddressBus, DataMemoryInputBus, DataMemoryOutputBus, sig_enable_data_memory_write ,sig_enable_data_memory_read );
	
	//--------Write Back -------------
	
	assign BusW1= (sig_write_back_data_select1 == LOW)? ALU_output:DataMemoryOutputBus;
	assign BusW2 = (sig_write_back_data_select2 == LOW)? 0: BusA+ 1'd1;	 
	assign returnAddress = BusW1;
	
	
	
	

endmodule	