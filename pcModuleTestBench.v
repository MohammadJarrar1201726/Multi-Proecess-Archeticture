module pcModuleTestBench ();

    // ----------------- CLOCK -----------------
    
    // clock generator wires/registers
	wire clock;

	// generates clock square wave with 10ns period
	ClockGenerator clock_generator(clock);

    // ----------------- PC Module Ports -----------------
 
    // register file wires/registers
    reg [1:0] pcSrc_control ;
	
    reg [31:0] returnAddress;
    reg signed [31:0] J_TypeImmediate, I_TypeImmediate;
    wire [31:0] PC;
    
    pcModule pcModule(clock, PC, I_TypeImmediate, J_TypeImmediate, returnAddress, pcSrc_control);
    
    // ----------------- Simulation -----------------

    initial begin

        
        // test the pc module by using different inputs and checking if the outputs are correct

        #0ns
        $display("(%0t) > PC=%0d", $time, PC);
        pcSrc_control <= PC_Src_Dft; // PC source default

        #10ns
        $display("(%0t) > PC=%0d", $time, PC);
        pcSrc_control <= PC_Src_Ra; // PC source default
        returnAddress <= 32'd2; // write value 2

        #10ns
        $display("(%0t) > PC=%0d", $time, PC);
        pcSrc_control <= PC_Src_JMP; // PC source default
        J_TypeImmediate <= 32'd10; // add 10 to PC
		
        #10ns
        $display("(%0t) > PC=%0d", $time, PC);
        pcSrc_control <= PC_Src_BTA; // PC source default
        I_TypeImmediate <= 32'd8; // add to PC via taken branch

        #10ns
        // results of previouse cycle
        $display("(%0t) > PC=%0d", $time, PC);

        #10ns $finish;    // 100 cycle
    end

endmodule

