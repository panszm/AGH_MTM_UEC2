`timescale 1 ns / 1 ps

module and2 (
    output logic y,
    input  logic a,
    input  logic b
);

    assign y = a & b;

endmodule
