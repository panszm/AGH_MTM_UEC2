`timescale 1 ns / 1 ps

module and2_tb;


logic a, b;
logic y;


// DUT
and2 dut(
    .y(y),
    .a(a),
    .b(b)
);


// PATTERN GENERATOR
initial begin
       {a,b} = 2'b00;
    #5 {a,b} = 2'b01;
    #5 {a,b} = 2'b10;
    #5 {a,b} = 2'b11;
    #5 $finish;
end


// DSIRED VALUES
logic exp_y;

assign exp_y = (a & b);


// MONITOR
always @* begin
    assert (y == exp_y) else
        $error("time: %0d\ta: %b\tb: %b\texp_y: %b\trec_y: %b", $time, a, b, exp_y, y);
end
        
endmodule
