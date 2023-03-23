/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Draw background.
 */


`timescale 1 ns / 1 ps

module draw_bg (
    input  logic clk,
    input  logic rst,

    input  logic [10:0] vcount_in,
    input  logic        vsync_in,
    input  logic        vblnk_in,
    input  logic [10:0] hcount_in,
    input  logic        hsync_in,
    input  logic        hblnk_in,

    vga_bus bus_out
);

import vga_pkg::*;


/**
 * Local variables and signals
 */

logic [11:0] rgb_nxt;


/**
 * Internal logic
 */

always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        bus_out.vcount <= '0;
        bus_out.vsync  <= '0;
        bus_out.vblnk  <= '0;
        bus_out.hcount <= '0;
        bus_out.hsync  <= '0;
        bus_out.hblnk  <= '0;
        bus_out.rgb    <= '0;
    end else begin
        bus_out.vcount <= vcount_in;
        bus_out.vsync  <= vsync_in;
        bus_out.vblnk  <= vblnk_in;
        bus_out.hcount <= hcount_in;
        bus_out.hsync  <= hsync_in;
        bus_out.hblnk  <= hblnk_in;
        bus_out.rgb    <= rgb_nxt;
    end
end

always_comb begin : bg_comb_blk
    if (vblnk_in || hblnk_in) begin             // Blanking region:
        rgb_nxt = 12'h0_0_0;                    // - make it it black.
    end else begin                              // Active region:
        if (vcount_in == 0)                     // - top edge:
            rgb_nxt = 12'hf_f_0;                // - - make a yellow line.
        else if (vcount_in == VISIBLE_HEIGHT - 1)   // - bottom edge:
            rgb_nxt = 12'hf_0_0;                // - - make a red line.
        else if (hcount_in == 0)                // - left edge:
            rgb_nxt = 12'h0_f_0;                // - - make a green line.
        else if (hcount_in == VISIBLE_WIDTH - 1)   // - right edge:
            rgb_nxt = 12'h0_0_f;                // - - make a blue line.

      //signature 21 pixs for WŚ
        else if(vcount_in == 300 && hcount_in == 401) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 301 && hcount_in == 400) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 301 && hcount_in == 401) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 301 && hcount_in == 402) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 302 && hcount_in == 400) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 303 && hcount_in == 400) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 303 && hcount_in == 401) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 303 && hcount_in == 402) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 304 && hcount_in == 402) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 305 && hcount_in == 400) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 305 && hcount_in == 401) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 305 && hcount_in == 402) rgb_nxt = 12'hf_f_f;

        else if(vcount_in == 301 && hcount_in == 394) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 302 && hcount_in == 394) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 300 && hcount_in == 394) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 303 && hcount_in == 394) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 304 && hcount_in == 394) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 305 && hcount_in == 394) rgb_nxt = 12'hf_f_f;

        else if(vcount_in == 304 && hcount_in == 395) rgb_nxt = 12'hf_f_f;
        
        else if(vcount_in == 302 && hcount_in == 396) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 303 && hcount_in == 396) rgb_nxt = 12'hf_f_f;

        else if(vcount_in == 304 && hcount_in == 397) rgb_nxt = 12'hf_f_f;

        else if(vcount_in == 301 && hcount_in == 398) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 302 && hcount_in == 398) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 300 && hcount_in == 398) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 303 && hcount_in == 398) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 304 && hcount_in == 398) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 305 && hcount_in == 398) rgb_nxt = 12'hf_f_f;

        else                                    // The rest of active display pixels:
            rgb_nxt = 12'h8_8_8;                // - fill with gray.
    end
end

endmodule
