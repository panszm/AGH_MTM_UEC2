`timescale 1 ns / 1 ps

module xor2 (
    output logic  y,
    input  logic a,
    input  logic b
);

    always_comb begin
        y = a ^ b;
    end

endmodule
