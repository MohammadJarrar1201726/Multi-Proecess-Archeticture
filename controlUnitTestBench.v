module controlUnitTestBench ();

    // ----------------- CLOCK -----------------
    
    // clock generator wires/registers
	wire clock;

	// generates clock square wave with 10ns period
	ClockGenerator clock_generator(clock);

    // ----------------- Inputs -----------------

    

    // function code
    reg [5:0] FunctionCode;

    // flags
    reg flag_zero; 
	reg flag_overflow;
	reg flag_carry ;
	reg flag_negative;
	
	

    

    // ----------------- Signals -----------------

    // multi-bit mux control signals
    wire [1:0] sig_alu_op;
    wire [1:0] sig_pc_src;
    wire sig_alu_src;	  
	wire [1:0] stack_value;

    // single bit mux control signals
    wire sig_write_back_data_select1
	,sig_write_back_data_select2,
       sig_reg_src , ext_op;

    // operation enable signals
    wire sig_rf_enable_write1, 
		sig_rf_enable_write2,
            sig_enable_data_memory_write,
            sig_enable_data_memory_read,
			SM;

    // stage enable signals ( used as clock for each stage )
    wire en_instruction_fetch,
            en_instruction_decode,
            en_execute;
    

    ControlUnit control_unit(
        clock,
        
        // signal outputs
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

        // stage enable outputs
        en_instruction_fetch,
        en_instruction_decode,
        en_execute,

        // inputs
        
        FunctionCode,
        flag_zero,
		flag_overflow,
		flag_negative
		
		
    );	
	
	initial begin	
		
		//AND 
		#0ns
		FunctionCode = AND;
		flag_zero = 0;
		flag_overflow = 0;
		flag_negative = 0;
		
		#40ns	   
		// ADDI   take 4 stages to complete
		FunctionCode = ADDI;
		flag_zero = 0;
		flag_overflow = 0;
		flag_negative = 0; 	
		#10ns
		$display("(%0t) > enble_read=%0d , sig_write_back_data_select1 = %0d", $time,sig_enable_data_memory_read , sig_write_back_data_select1);
		
		#40ns 
		//LW	take 5 stages to complete 
		FunctionCode= LW;
		flag_zero = 0;
		flag_overflow = 0;
		flag_negative = 0;	
		#30ns
		$display("(%0t) > enble_read=%0d , sig_write_back_data_select1 = %0d", $time,sig_enable_data_memory_read , sig_write_back_data_select1);	  
		#10ns
		FunctionCode = SW; 	 
		#10ns
		$display("(%0t) > enble_write=%0d",  $time,sig_enable_data_memory_write);  
		$display("(%0t) > alu_op=%0d", $time,sig_enable_data_memory_write);
		
		#50ns 
		FunctionCode = RET;
		flag_zero = 0;
		flag_overflow = 0;
		flag_negative = 0;
		#10ns $finish;	  
		
		
		
		
		
		
	end
	
   
    


endmodule