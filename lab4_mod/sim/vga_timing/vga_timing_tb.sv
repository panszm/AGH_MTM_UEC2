/**
 *  Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Testbench for vga_timing module.
 */

`timescale 1 ns / 1 ps

module vga_timing_tb;

import vga_pkg::*;


/**
 *  Local parameters
 */

localparam CLK_PERIOD = 25;     // 40 MHz


/**
 * Local variables and signals
 */

logic clk;
logic rst;

wire [10:0] vcount, hcount;
wire        vsync,  hsync;
wire        vblnk,  hblnk;


/**
 * Clock generation
 */

initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end


/**
 * Reset generation
 */

initial begin
    //                    rst = 1'b0;
    // #(1.25*CLK_PERIOD) rst = 1'b1;
                       rst = 1'b1;
    #(2.00*CLK_PERIOD) rst = 1'b0;
end


/**
 * Dut placement
 */

vga_timing dut(
    .clk,
    .rst,
    .vcount,
    .vsync,
    .vblnk,
    .hcount,
    .hsync,
    .hblnk
);

/**
 * Tasks and functions
 */

 // Here you can declare tasks with immediate assertions (assert).

/**
 * Assertions
 */
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


/**
 * Main test
 */

initial begin
    // @(posedge rst);
    @(negedge rst);

    wait (vsync == 1'b0);
    @(negedge vsync)
    @(negedge vsync)

    $finish;
end

endmodule
