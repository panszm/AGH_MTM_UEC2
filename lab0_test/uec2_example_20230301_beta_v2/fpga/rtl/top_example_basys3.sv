`timescale 1 ns / 1 ps

module top_example_basys3 (
    input clk,
    input btnC,
    input  wire [1:0]  sw,
    output wire [1:0] led
);

    top_example top_example (
        .clk(clk),
        .rst(btnC),
        .a(sw[0]),
        .b(sw[1]),
        .sum(led[0]),
        .carry(led[1])
    );

endmodule
