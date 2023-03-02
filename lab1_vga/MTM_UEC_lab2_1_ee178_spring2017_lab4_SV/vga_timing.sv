// File: vga_timing.sv
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_timing (
  output logic [10:0] vcount,
  output logic vsync,
  output logic vblnk,
  output logic [10:0] hcount,
  output logic hsync,
  output logic hblnk,
  input  logic pclk
  );

  // Describe the actual circuit for the assignment.
  // Video timing controller set for 800x600@60fps
  // using a 40 MHz pixel clock per VESA spec.

endmodule
