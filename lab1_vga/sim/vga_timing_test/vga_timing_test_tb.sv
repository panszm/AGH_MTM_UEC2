// File: testbench.sv
// This is a top level testbench for the
// vga_example design, which is part of
// the EE178 Lab #4 assignment.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

module vga_timing_test_tb;

  // Declare signals to be driven by the outputs
  // of the design, and to drive the inputs.
  // The testbench will be in control of inputs
  // to the design, and will check the outputs.
  // Then, instantiate the design to be tested.

  logic rst;
  logic clk;
  logic pclk_mirror;
  logic [10:0] vcount, hcount;
  logic vsync, hsync;
  logic vblnk, hblnk;

  // Instantiate the vga_example module.
  

  vga_timing my_timing (
    .vcount(vcount),
    .vsync(vsync),
    .vblnk(vblnk),
    .hcount(hcount),
    .hsync(hsync),
    .hblnk(hblnk),
    .pclk(clk),
    .rst(rst)
  );

  // Instantiate the tiff_writer module.

  // tiff_writer my_writer (
  //   .pclk_mirror(pclk_mirror),
  //   .r({r,r}), // fabricate an 8-bit value
  //   .g({g,g}), // fabricate an 8-bit value
  //   .b({b,b}), // fabricate an 8-bit value
  //   .go(vs),
  //   .xdim(16'd1056),
  //   .ydim(16'd628)
  // );

  // Describe a process that generates a clock
  // signal. The clock is 40 MHz.

  always
  begin
    clk = 1'b0;
    #12.5;
    clk = 1'b1;
    #12.5;
  end

  // Assign values to the input signals and
  // check the output results. This template
  // is meant to get you started, you can modify
  // it as you see fit. If you simply run it as
  // provided, you will need to visually inspect
  // the output waveforms to see if they make
  // sense...

  initial
  begin
    rst = 1;
    #30
    rst = 0;
    $display("If simulation ends before the testbench");
    $display("completes, use the menu option to run all.");
    $display("Prepare to wait a long time...");
    wait (vsync == 1'b0);
    @(negedge vsync) $display("Info: negedge VS at %t",$time);
    @(negedge vsync) $display("Info: negedge VS at %t",$time);
    // End the simulation.
    $display("Simulation is over, check the waveforms.");
    $stop;
  end
  
  parameter VISIBLE_HEIGHT = 600,
        VERTICAL_FRONT_PORCH = 1,
        VERTICAL_SYNC_PULSE = 4,
        FULL_HEIGHT = 628,
        
        VISIBLE_WIDTH = 800,
        HORIZONTAL_FRONT_PORCH = 40,
        HORIZONTAL_SYNC_PULSE = 128,
        FULL_WIDTH = 1056;

  always_ff @(posedge clk) begin
    if(!rst) begin
      assert (hcount < FULL_WIDTH) else
          $error("hcount overflow, time: %0d\thcount: %d\tFULL_WIDTH: %d", $time, hcount, FULL_WIDTH);
      assert (vcount < FULL_HEIGHT) else
          $error("vcount overflow, time: %0d\tvcount: %d\tFULL_WIDTH: %d", $time, vcount, FULL_HEIGHT);
      
      if(hcount >= VISIBLE_WIDTH) begin
        assert (hblnk) else
            $error("hblnk firing too late, time: %0d\thblnk: %d\tVISIBLE_WIDTH: %d\thcount: %d", $time, hblnk, VISIBLE_WIDTH, hcount);
      end else begin
        assert (!hblnk) else
            $error("hblnk firing too early, time: %0d\thblnk: %d\tVISIBLE_WIDTH: %d\thcount: %d", $time, hblnk, VISIBLE_WIDTH, hcount);
      end
      if(vcount >= VISIBLE_HEIGHT) begin
        assert (vblnk) else
            $error("vblnk firing too late, time: %0d\tvblnk: %d\tVISIBLE_HEIGHT: %d\tvcount: %d", $time, vblnk, VISIBLE_HEIGHT, vcount);
      end else begin
        assert (!vblnk) else
            $error("vblnk firing too early, time: %0d\tvblnk: %d\tVISIBLE_WIDTH: %d\tvcount: %d", $time, vblnk, VISIBLE_HEIGHT, vcount);
      end

      if(hcount >= (VISIBLE_WIDTH + HORIZONTAL_FRONT_PORCH) && hcount < (VISIBLE_WIDTH + HORIZONTAL_FRONT_PORCH + HORIZONTAL_SYNC_PULSE)) begin
        assert (hsync) else
            $error("hsync not firing in the right time, time: %0d\thsync: %d\tVISIBLE_WIDTH: %d\thcount: %d", $time, hsync, VISIBLE_WIDTH, hcount);
      end else if(hcount < (VISIBLE_WIDTH + HORIZONTAL_FRONT_PORCH) || hcount >= (VISIBLE_WIDTH + HORIZONTAL_FRONT_PORCH + HORIZONTAL_SYNC_PULSE)) begin
        assert (!hsync) else
            $error("hsync firing out of given boundaries, time: %0d\thblnk: %d\tVISIBLE_WIDTH: %d\thcount: %d", $time, hsync, VISIBLE_WIDTH, hcount);
      end
      if(vcount >= (VISIBLE_HEIGHT + VERTICAL_FRONT_PORCH) && vcount < (VISIBLE_HEIGHT + VERTICAL_FRONT_PORCH + VERTICAL_SYNC_PULSE)) begin
        assert (vsync) else
            $error("vsync not firing in the right time, time: %0d\tvsync: %d\tVISIBLE_HEIGHT: %d\tvcount: %d", $time, vsync, VISIBLE_HEIGHT, vcount);
      end else if(vcount < (VISIBLE_HEIGHT + VERTICAL_FRONT_PORCH) || vcount >= (VISIBLE_HEIGHT + VERTICAL_FRONT_PORCH + VERTICAL_SYNC_PULSE)) begin
        assert (!vsync) else
            $error("vsync firing out of given boundaries, time: %0d\tvblnk: %d\tVISIBLE_HEIGHT: %d\tvcount: %d", $time, vsync, VISIBLE_HEIGHT, vcount);
      end
    end
  end

endmodule
