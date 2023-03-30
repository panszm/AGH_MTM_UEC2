/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Vga timing controller.
 */

`timescale 1 ns / 1 ps

module vga_timing (
    input  logic clk,
    input  logic rst,
    output logic [10:0] vcount,
    output logic vsync,
    output logic vblnk,
    output logic [10:0] hcount,
    output logic hsync,
    output logic hblnk
);

import vga_pkg::*;


/**
 * Local variables and signals
 */
logic[10:0] vcount_nxt;
logic[10:0] hcount_nxt;

logic vsync_nxt;
logic hsync_nxt;

logic vblnk_nxt;
logic hblnk_nxt;


/**
 * Internal logic
 */

always_comb begin
  hcount_nxt = (hcount + 1) % FULL_WIDTH;
  if(hcount == FULL_WIDTH - 1) begin
    vcount_nxt = (vcount + 1) % FULL_HEIGHT;
  end else begin
    vcount_nxt = vcount;
  end
end

always_comb begin
  if(hcount_nxt >= VISIBLE_WIDTH && hcount_nxt < FULL_WIDTH) begin
    hblnk_nxt = 1;
  end else begin
    hblnk_nxt = 0;
  end
  
  if(hcount_nxt >= (VISIBLE_WIDTH + HORIZONTAL_FRONT_PORCH) && hcount_nxt < (VISIBLE_WIDTH + HORIZONTAL_FRONT_PORCH + HORIZONTAL_SYNC_PULSE)) begin
    hsync_nxt = 1;
  end else begin
    hsync_nxt = 0;
  end
  
  if((vcount_nxt >= VISIBLE_HEIGHT && vcount_nxt < FULL_HEIGHT)) begin
    vblnk_nxt = 1;
  end else begin
    vblnk_nxt = 0;
  end
  
  if(vcount_nxt >= (VISIBLE_HEIGHT + VERTICAL_FRONT_PORCH) && vcount_nxt < (VISIBLE_HEIGHT + VERTICAL_FRONT_PORCH + VERTICAL_SYNC_PULSE)) begin
    vsync_nxt = 1;
  end else begin
    vsync_nxt = 0;
  end
end

always_ff @ (posedge clk) begin
  if(rst) begin
    vcount <= 0;
    hcount <= 0;

    vsync <= 0;
    hsync <= 0;

    vblnk <= 0;
    hblnk <= 0;
  end else begin
    vcount <= vcount_nxt;
    hcount <= hcount_nxt;

    vsync <= vsync_nxt;
    hsync <= hsync_nxt;

    vblnk <= vblnk_nxt;
    hblnk <= hblnk_nxt;
  end
end


endmodule
