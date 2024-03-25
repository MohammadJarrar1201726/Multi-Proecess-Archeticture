module instructionMemoryTestBench ();

    // ----------------- CLOCK -----------------
    
    // clock generator wires/registers
	wire clock;

	// generates clock square wave with 10ns period
	ClockGenerator clock_generator(clock);

    // ----------------- Instruction Memory -----------------
 
    // instruction memory wires/registers		
    reg [31:0] addressBus;
    wire [31:0] instructionReg;
    
    instructionMemory IM(clock, addressBus, instructionReg);
	
    // ----------------- Simulation -----------------

    initial begin

        #0ns
        addressBus <= 5'd0; // set address to 0
        
        #5ns
        addressBus <= 5'd1; // set address to 1
        
        #10ns
        addressBus <= 5'd2; // set address to 2

        #10ns
        addressBus <= 5'd3; // set address to 3

        #10ns $finish;    // 100 cycle
    end

endmodule