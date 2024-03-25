
// register file (array of 32 bit 16 registers)

module registerFile(clock , RA , RB , RW, enable_write1 , enable_write2 , BusW1 , BusW2 , BusA, BusB);
	
	//---------------PORTS -----------------
	
	//clock
	input wire clock;
	
	//enabe write 1 and 2
	input wire enable_write1;
	input wire enable_write2;
	
	//register selection buses
	
	input wire [3:0] RA, RB , RW;
	
	// data read buses A & B
	output reg [31:0] BusA, BusB;	 
	
	// data write buses
	input wire [31:0] BusW1;
	input wire [31:0] BusW2;
	
	//-------- INTERNALS ------------
	
	reg [31:0] register_array [0:15]  ;
	
	// read register always
	
	always @(posedge clock) begin
		BusA = register_array[RA];
		BusB = register_array[RB];
		
	end
	// write on the register
	always @(posedge enable_write1) begin
		register_array[RW] = BusW1;
	end	   	
	
	always @(posedge enable_write2) begin
		register_array[RA] = BusW2;  
	end
		
	
	
	initial begin
		register_array[0]  <= 32'h00000000;
		register_array[1]  <= 32'h00000000;
		register_array[2]  <= 32'h00000000;
		register_array[3]  <= 32'h00000000;
		register_array[4]  <= 32'h00000000;
		register_array[5]  <= 32'h00000000;
		register_array[6]  <= 32'h00000000;
		register_array[7]  <= 32'h00000000;
		register_array[8]  <= 32'h00000000;
		register_array[9]  <= 32'h00000000;
		register_array[10]  <= 32'h00000000;
		register_array[11]  <= 32'h00000000;
		register_array[12]  <= 32'h00000000;
		register_array[13]  <= 32'h00000000;
		register_array[14]  <= 32'h00000000;
		register_array[15]  <= 32'h00000000;
	
	end
	
endmodule