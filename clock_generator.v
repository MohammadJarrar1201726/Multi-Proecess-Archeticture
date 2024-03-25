// generates clock square wave with 10ns period

module ClockGenerator (
    clock
);

initial begin
    $display("(%0t) > initializing clock generator ...", $time);
end

output reg clock=10ns; // starting LOW is important for first instruction fetch

always #5ns begin

    clock=~clock;
end
					   

endmodule