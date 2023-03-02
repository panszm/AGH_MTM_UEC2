`timescale 1 ns / 1 ps

module top_example (
    input  logic clk,
    input  logic rst,
    input  logic a,
    input  logic b,
    output logic sum,
    output logic carry
);

    xor2 xor2 (
        .y(sum),
        .a(a),
        .b(b)
    );

    and2 and2 (
        .y(carry),
        .a(a),
        .b(b)
    );

endmodule
