/*
module ALUTestBench();

	// ----------------- CLOCK -----------------
    
    // clock generator wires/registers
	wire clock;

	// generates clock square wave with 10ns period
	ClockGenerator clock_generator(clock);

    // ----------------- ALU -----------------

    reg [31:0] A, B; // operands
    wire [31:0] Output;
    wire flag_zero;
    wire flag_negative;	
	wire flag_overflow;
	


    // signals
    reg [1:0] sig_alu_op;


    ALU alu(clock, A, B, Output, flag_zero, flag_negative , flag_overflow, sig_alu_op);
	
    // ----------------- Simulation -----------------
		/*
    initial
		begin

        #0ns
        A <= 32'd10;
        B <= 32'd20;
        sig_alu_op <= ALU_ADD;

        #10ns
        $display("(%0t) > A=%0d + B=%0d => Output=%0d | zero_flag=%0b | negative_flag=%0b|flag_overflow = %0b", $time, A, B, Output, flag_zero, flag_negative , flag_overflow);

        A <= 32'd30;
        B <= 32'd20;
        sig_alu_op <= ALU_Sub;

        #10ns
        $display("(%0t) > A=%0d - B=%0d => Output=%0d | zero_flag=%0b | negative_flag=%0b| flag_overflow = %0b", $time, A, B, Output, flag_zero, flag_negative , flag_overflow);

        A <= 32'h00000F0F;
        B <= 32'h00000FFF;
        sig_alu_op <= ALU_And;

        #10ns
        $display("(%0t) > A=%0h & B=%0h => Output=%0h | zero_flag=%0b | negative_flag=%0b | flag_overflow = %0b", $time, A, B, Output, flag_zero, flag_negative , flag_overflow);

       

        A <= 32'd50;
        B <= 32'd50;
        sig_alu_op <= ALU_Sub;

        #10ns
        $display("(%0t) > A=%0d - B=%0d => Output=%0d | zero_flag=%0b | negative_flag=%0b| flag_overflow = %0b", $time, A, B, Output, flag_zero, flag_negative , flag_overflow);

        A <= 32'd50;
        B <= 32'd100;
        sig_alu_op <= ALU_Sub;

        #10ns
        $display("(%0t) > A=%0d - B=%0d => Output=%0d | zero_flag=%0b | negative_flag=%0b|flag_overflow = %0b", $time, A, B, $signed(Output), flag_zero, flag_negative , flag_overflow );


        #5ns $finish;
    end
	
	
	
	
	initial begin
    #0ns
    A <= 32'd10;
    B <= 32'd20;
    sig_alu_op <= ALU_ADD;

    #10ns
    $display("(%0t) > A=%0d + B=%0d => Output=%0d | zero_flag=%0b | negative_flag=%0b|flag_overflow = %0b", $time, A, B, Output, flag_zero, flag_negative , flag_overflow);

    A <= 32'd30;
    B <= 32'd20;
    sig_alu_op <= ALU_Sub;

    #10ns
    $display("(%0t) > A=%0d - B=%0d => Output=%0d | zero_flag=%0b | negative_flag=%0b| flag_overflow = %0b", $time, A, B, Output, flag_zero, flag_negative , flag_overflow);

    A <= 32'h00000F0F;
    B <= 32'h00000FFF;
    sig_alu_op <= ALU_And;

    #10ns
    $display("(%0t) > A=%0h & B=%0h => Output=%0h | zero_flag=%0b | negative_flag=%0b | flag_overflow = %0b", $time, A, B, Output, flag_zero, flag_negative , flag_overflow);

    A <= 32'd50;
    B <= 32'd50;
    sig_alu_op <= ALU_Sub;

    #10ns
    $display("(%0t) > A=%0d - B=%0d => Output=%0d | zero_flag=%0b | negative_flag=%0b| flag_overflow = %0b", $time, A, B, Output, flag_zero, flag_negative , flag_overflow);

    A <= 32'd50;
    B <= 32'd100;
    sig_alu_op <= ALU_Sub;

    #10ns
    $display("(%0t) > A=%0d - B=%0d => Output=%0d | zero_flag=%0b | negative_flag=%0b|flag_overflow = %0b", $time, A, B, $signed(Output), flag_zero, flag_negative , flag_overflow );

    #5ns $finish;
end

endmodule	
*/ 


module ALUTestBench();

    // ----------------- CLOCK -----------------
    
    // clock generator wires/registers
    wire clock;

    // generates clock square wave with 10ns period
    ClockGenerator clock_generator(clock);

    // ----------------- ALU -----------------

    reg [31:0] A, B; // operands
    wire [31:0] Output;
    wire flag_zero;
    wire flag_negative;    
    wire flag_overflow;	 
	wire flag_carry;
    
    // signals
    reg [1:0] sig_alu_op;

    ALU alu(clock, A, B, Output, flag_zero, flag_negative , flag_overflow,  sig_alu_op);
    
    // ----------------- Simulation -----------------

    initial begin
        #0ns
        A <= 32'd10;
        B <= 32'd20;
        sig_alu_op <= 2'b00;

        #10ns
        $display("(%0t) > A=%0d + B=%0d => Output=%0d | zero_flag=%0b | negative_flag=%0b|flag_overflow = %0b", $time, A, B, Output, flag_zero, flag_negative , flag_overflow);

        A <= 32'd30;
        B <= 32'd20;
        sig_alu_op <= ALU_Sub;

        #10ns
        $display("(%0t) > A=%0d - B=%0d => Output=%0d | zero_flag=%0b | negative_flag=%0b| flag_overflow = %0b", $time, A, B, Output, flag_zero, flag_negative , flag_overflow);

        A <= 32'h00000F0F;
        B <= 32'h00000FFF;
        sig_alu_op <= ALU_And;

        #10ns
        $display("(%0t) > A=%0h & B=%0h => Output=%0h | zero_flag=%0b | negative_flag=%0b | flag_overflow = %0b", $time, A, B, Output, flag_zero, flag_negative , flag_overflow);

        A <= 32'd50;
        B <= 32'd50;
        sig_alu_op <= ALU_Sub;

        #10ns
        $display("(%0t) > A=%0d - B=%0d => Output=%0d | zero_flag=%0b | negative_flag=%0b| flag_overflow = %0b", $time, A, B, Output, flag_zero, flag_negative , flag_overflow);

        A <= 32'd50;
        B <= 32'd100;
        sig_alu_op <= ALU_Sub;

        #10ns
        $display("(%0t) > A=%0d - B=%0d => Output=%0d | zero_flag=%0b | negative_flag=%0b|flag_overflow = %0b", $time, A, B, $signed(Output), flag_zero, flag_negative , flag_overflow );

        #5ns $finish;
    end

endmodule
