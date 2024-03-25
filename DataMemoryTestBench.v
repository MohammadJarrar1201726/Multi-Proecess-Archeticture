module dataMemoryTestBench();
	
	

    // ----------------- CLOCK -----------------
    
    // clock generator wires/registers
	wire clock;

	// generates clock square wave with 10ns period
	ClockGenerator clock_generator(clock);

    // ----------------- Data Memory -----------------

    // data memory wires/registers/signals
    reg [31:0] DataMemoryAddressBus;
    reg [31:0] DataMemoryInputBus;
    wire [31:0] DataMemoryOutputBus;

    // signals
    reg sig_enable_data_memory_write ;
    reg sig_enable_data_memory_read; 
	 
	
	wire flag_full, flag_empty;


    DataMemory data_memory(clock, DataMemoryAddressBus, DataMemoryInputBus, DataMemoryOutputBus, sig_enable_data_memory_write, sig_enable_data_memory_read);
	
    // ----------------- Simulation -----------------

    initial begin

        
        // test the memory by writing and reading some values from it from different addresses
        // and checking if the values are correct

        #0ns
        DataMemoryAddressBus <= 5'd1; // address 1
        sig_enable_data_memory_read <= 1; // enable read  
		

        #10ns
        $display("(%0t) > DataMemoryOutputBus=%0d", $time, DataMemoryOutputBus);
        DataMemoryAddressBus <= 5'd1; // address 1 
		

        DataMemoryInputBus <= 32'd32; // write value 32

        sig_enable_data_memory_read <= 0; // disable read
        sig_enable_data_memory_write <= 1; // enable write
		
        
        #10ns
        DataMemoryAddressBus <= 5'd1; // address 1
        sig_enable_data_memory_read <= 1; // enable read
		sig_enable_data_memory_write <= 0;
		
        #10ns
        $display("(%0t) > DataMemoryOutputBus=%0d", $time, DataMemoryOutputBus);
		
		 // Stack
		#10ns
        DataMemoryInputBus <= 32'd16; // write value 16
        sig_enable_data_memory_write<= 1; // enable write
		sig_enable_data_memory_read <= 0;
		

        #10ns
       	DataMemoryInputBus <= 32'd64; // write value 64

        #10ns
        DataMemoryInputBus <= 32'd32; // write value 32

        #10ns
         DataMemoryInputBus <= 32'd1; // write value 1

        #10ns
         DataMemoryInputBus <= 32'd2; // write value 2

        #10ns
         DataMemoryInputBus <= 32'd3; // write value 3
        

        #10ns
         sig_enable_data_memory_read <= 1; // enable read
         sig_enable_data_memory_write <= 0; // disable write 
		
        DataMemoryInputBus <= 32'd0; // write value 3

		$display("Stack");
        #10ns
        $display("(%0t) > DataOut=%0d", $time, DataMemoryOutputBus);

        #10ns
        $display("(%0t) > DataOut=%0d", $time, DataMemoryOutputBus);

        #10ns
        $display("(%0t) > DataOut=%0d", $time, DataMemoryOutputBus);

        #10ns
        $display("(%0t) > DataOut=%0d", $time, DataMemoryOutputBus);

        #10ns
        $display("(%0t) > DataOut=%0d", $time, DataMemoryOutputBus);

        #10ns
        $display("(%0t) > DataOut=%0d", $time, DataMemoryOutputBus);

        #10ns
        $display("(%0t) > DataOut=%0d", $time, DataMemoryOutputBus);

		
        #10ns $finish;  
    end

endmodule