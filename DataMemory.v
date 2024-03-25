
module DataMemory(clock , addressBus, inputBus , outputBus, enable_write , enable_read);
	
	//-----------SIGNALS ---------------
	
	//clock
	input wire clock;
	
	//enable write signal
	input wire enable_write;
	
	// enable read signal
	input wire enable_read;
	
	//----------INPUTS------------
	
	//address bus
	input wire [31:0] addressBus;
	
	//input
	input wire [31:0] inputBus;
	
	//------------OUTPUTS------------
	
	//output
	output reg[31:0] outputBus;
		
	//stackpointer 
	
	//memory
	reg [31:0] memory [0:255];	
	
	
	// stack memory from 223 to 255

	always @(posedge clock)
	begin			 
				  
		if (enable_read) begin		
            outputBus <= memory[addressBus];  
			$display("DataMemory:  enable_data_memory_read = %b, addressBus = %0d , DataOutput = %0d", enable_read,addressBus,  outputBus);
			end
		else if (enable_write) begin   
            memory[addressBus] <= inputBus;
			$display("DataMemory:  enable_data_memory_write = %b , address_Bus = %0d, InputValue = %0d",  enable_write , addressBus, inputBus);
        	end
	end	
	
	 // ----------------- INITIALIZATION -----------------
   
    initial begin
        
        // store some initial data
        memory[0] = 32'd10;
        memory[1] = 32'd5;
        
    end	 

	
endmodule
