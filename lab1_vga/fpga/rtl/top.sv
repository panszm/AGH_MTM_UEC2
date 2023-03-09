// File: vga_example.sv
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports.

module top (
  input  logic clk,
  input  logic rst,
  output logic vs,
  output logic hs,
  output logic [3:0] r,
  output logic [3:0] g,
  output logic [3:0] b,
  output logic pclk_mirror
  );

  // Converts 100 MHz clk into 40 MHz pclk.
  // This uses a vendor specific primitive
  // called MMCME2, for frequency synthesis.

  logic clk_in;
  logic locked;
  logic clk_fb;
  logic clk_ss;
  logic clk_out;
  logic pclk;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  logic [7:0] safe_start = 0;

  IBUF clk_ibuf (.I(clk),.O(clk_in));

  MMCME2_BASE #(
    .CLKIN1_PERIOD(10.000),
    .CLKFBOUT_MULT_F(10.000),
    .CLKOUT0_DIVIDE_F(25.000))
  clk_in_mmcme2 (
    .CLKIN1(clk_in),
    .CLKOUT0(clk_out),
    .CLKOUT0B(),
    .CLKOUT1(),
    .CLKOUT1B(),
    .CLKOUT2(),
    .CLKOUT2B(),
    .CLKOUT3(),
    .CLKOUT3B(),
    .CLKOUT4(),
    .CLKOUT5(),
    .CLKOUT6(),
    .CLKFBOUT(clkfb),
    .CLKFBOUTB(),
    .CLKFBIN(clkfb),
    .LOCKED(locked),
    .PWRDWN(1'b0),
    .RST(1'b0)
  );

  BUFH clk_out_bufh (.I(clk_out),.O(clk_ss));
  always_ff @(posedge clk_ss) safe_start<= {safe_start[6:0],locked};

  BUFGCE clk_out_bufgce (.I(clk_out),.CE(safe_start[7]),.O(pclk));

  // Mirrors pclk on a pin for use by the testbench;
  // not functionally required for this design to work.

  ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(pclk),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
  );

  // Instantiate the vga_timing module, which is
  // the module you are designing for this lab.

  logic [10:0] vcount, hcount;
  logic vsync, hsync;
  logic vblnk, hblnk;

  vga_timing my_timing (
    .vcount(vcount),
    .vsync(vsync),
    .vblnk(vblnk),
    .hcount(hcount),
    .hsync(hsync),
    .hblnk(hblnk),
    .pclk(pclk),
    .rst(rst)
  );

  // This is a simple test pattern generator.
  
  always_ff @(posedge pclk)
  begin
    // Just pass these through.
    hs <= hsync;
    vs <= vsync;
    // During blanking, make it it black.
    if (vblnk || hblnk) {r,g,b} <= 12'h0_0_0; 
    else
    begin
      // Frame, to test for correct sync
      if (vcount == 0) {r,g,b} <= 12'hf_f_0;
      else if (vcount == 599) {r,g,b} <= 12'hf_0_0;
      else if (hcount == 0) {r,g,b} <= 12'h0_f_0;
      else if (hcount == 799) {r,g,b} <= 12'h0_0_f;
      else begin 
      //signature 21 pixs for Ś4
        if(vcount == 300 && hcount == 401) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 301 && hcount == 400) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 301 && hcount == 401) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 301 && hcount == 402) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 302 && hcount == 400) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 303 && hcount == 400) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 303 && hcount == 401) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 303 && hcount == 402) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 304 && hcount == 402) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 305 && hcount == 400) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 305 && hcount == 401) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 305 && hcount == 402) {r,g,b} <= 12'hf_f_f;

        else if(vcount == 301 && hcount == 394) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 302 && hcount == 394) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 300 && hcount == 394) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 303 && hcount == 394) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 304 && hcount == 394) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 305 && hcount == 394) {r,g,b} <= 12'hf_f_f;

        else if(vcount == 304 && hcount == 395) {r,g,b} <= 12'hf_f_f;
        
        else if(vcount == 302 && hcount == 396) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 303 && hcount == 396) {r,g,b} <= 12'hf_f_f;

        else if(vcount == 304 && hcount == 397) {r,g,b} <= 12'hf_f_f;

        else if(vcount == 301 && hcount == 398) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 302 && hcount == 398) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 300 && hcount == 398) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 303 && hcount == 398) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 304 && hcount == 398) {r,g,b} <= 12'hf_f_f;
        else if(vcount == 305 && hcount == 398) {r,g,b} <= 12'hf_f_f;
        
        else {r,g,b} <= 12'h8_8_8;
      end
    end
  end

endmodule
