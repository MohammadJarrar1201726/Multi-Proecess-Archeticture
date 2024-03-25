module registerFileTestBench ();

    // ----------------- CLOCK -----------------
    
    // clock generator wires/registers
	wire clock;

	// generates clock square wave with 10ns period
	ClockGenerator clock_generator(clock);

    // ----------------- Register File -----------------
 
    // register file wires/registers
    reg [3:0] RA, RB, RW;
    reg enable_write1;
	reg enable_write2;
	
    reg [31:0] BusW1 , BusW2;
    wire [31:0] BusA, BusB;
    
    // register file ( array of 32 registers )
    registerFile register_file(clock, RA, RB, RW, enable_write1, enable_write2 , BusW1 , BusW2 , BusA, BusB);
    
    // ----------------- Simulation -----------------

    initial begin

        
        // test the register file by writing and reading some values from it from different registers
        // and checking if the values are correct

        #0ns
        RW <= 4'd1; // write to register 1
		RA <= 4'd2; // write to register 2
        BusW1 <= 32'd16; // write value 16 
		BusW2 <= 32'd2; // write value 2
        enable_write1 <= 1; // enable write1
		enable_write2 <= 1;// enable write 2
		
		
		   #10ns
        RA <= 4'd1;
        RB <= 4'd2;
        enable_write1 <= 0; // enable write1
		enable_write2 <=0; // enable write2
        #10ns

        // results of previouse cycle
        $display("(%0t) > BusA=%0d, BusB=%0d", $time, BusA, BusB);	  
		
		
        #10ns
        RW <= 4'd2; // write to register 2 
		RA <= 4'd5; // write to register 5
        BusW1 <= 32'd32; // write value 32
		BusW2 <=32'd 3 ;
        enable_write1 <= 1; // enable write1
		enable_write2 <=0; // enable write2 
		
        #10ns
        RA <= 5'd1;
        RB <= 5'd2;
        enable_write1 <= 0; // enable write1
		enable_write2 <=0; // enable write2
        #10ns

        // results of previouse cycle
        $display("(%0t) > BusA=%0d, BusB=%0d", $time, BusA, BusB);


        // test overwrite
        RW <= 5'd2; // write to register 2
        BusW1 <= 32'd64; // write value 32 
		BusW2 <= 32'd0; // write value 0
        enable_write1 <= 1; // enable write1
		enable_write2 <= 0; // enable write2
		

        #10ns
        $display("(%0t) > BusA=%0d, BusB=%0d", $time, BusA, BusB);

        // test write without write signal
        RW <= 5'd2; // write to register 2
        BusW1 <= 32'd128; // write value 32
        enable_write1 <= 0; // disable write

        #10ns
        $display("(%0t) > BusA=%0d, BusB=%0d", $time, BusA, BusB);


        #10ns $finish;    // 100 cycle
    end

endmodule