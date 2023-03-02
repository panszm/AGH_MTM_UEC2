`timescale 1 ns / 1 ps

// TODO: testbench ma zegar, ale top nie. jesli top bedzie dzialal na zegarze pojawia sie opoxnienia i trzeba zastosowac kolejki

module top_example_tb;

 logic clk;
 logic rst;
 logic sum;
 logic carry;
 logic a;
 logic b;


top_example dut (
    .clk(clk),
    .rst(rst),
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
);


// CLOCK
localparam CLK_PERIOD = 10;
initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end


// RESET
initial begin
                       rst = 1'b0;
    #(1.25*CLK_PERIOD) rst = 1'b1;
    #(2.00*CLK_PERIOD) rst = 1'b0;
end


// PATTERN GENERATOR
logic [3:0] test_vector [3:0];
initial begin
    test_vector [0] = {1'b0,1'b0,1'b0,1'b0};
    test_vector [1] = {1'b0,1'b1,1'b1,1'b0};
    test_vector [2] = {1'b1,1'b0,1'b1,1'b0};
    test_vector [3] = {1'b1,1'b1,1'b1,1'b1};
end


// DRIVER
integer i;

initial begin
    {a,b} = 0;
    @(posedge rst);
    @(negedge rst);
    for (i = 0; i < 4; i++) begin
        @(negedge clk);
        {a,b} = test_vector[i][3:2];
    end
    @(negedge clk)
    
    $finish;
end


// MONITOR
logic  exp_sum;
logic  exp_carry;

assign exp_sum = a+b;
assign exp_carry = a&b;

initial begin
    @(posedge rst)
    forever begin
        @(negedge clk);     // dut set outputs @ posedge clk
        assert(sum == exp_sum) else
            $error("time: %4d\trst: %b\ta: %b\tb: %b\trec_sum: %b\texp_sum: %b", $time, rst, a, b, sum, exp_sum);
        assert(carry == exp_carry) else
            $error("time: %4d\trst: %b\ta: %b\tb: %b\trec_carry: %b\texp_carry: %b", $time, rst, a, b, sum, carry, exp_carry);
    end 
end        

endmodule
