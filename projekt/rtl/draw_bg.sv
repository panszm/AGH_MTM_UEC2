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
      //signature 21 pixs for WŚ
        if(vcount_in == 0 && hcount_in == 11) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 1 && hcount_in == 10) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 1 && hcount_in == 11) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 1 && hcount_in == 12) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 2 && hcount_in == 10) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 3 && hcount_in == 10) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 3 && hcount_in == 11) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 3 && hcount_in == 12) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 4 && hcount_in == 12) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 5 && hcount_in == 10) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 5 && hcount_in == 11) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 5 && hcount_in == 12) rgb_nxt = 12'hf_f_f;

        else if(vcount_in == 1 && hcount_in == 4) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 2 && hcount_in == 4) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 0 && hcount_in == 4) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 3 && hcount_in == 4) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 4 && hcount_in == 4) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 5 && hcount_in == 4) rgb_nxt = 12'hf_f_f;

        else if(vcount_in == 4 && hcount_in == 5) rgb_nxt = 12'hf_f_f;
        
        else if(vcount_in == 2 && hcount_in == 6) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 3 && hcount_in == 6) rgb_nxt = 12'hf_f_f;

        else if(vcount_in == 4 && hcount_in == 7) rgb_nxt = 12'hf_f_f;

        else if(vcount_in == 1 && hcount_in == 8) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 2 && hcount_in == 8) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 0 && hcount_in == 8) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 3 && hcount_in == 8) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 4 && hcount_in == 8) rgb_nxt = 12'hf_f_f;
        else if(vcount_in == 5 && hcount_in == 8) rgb_nxt = 12'hf_f_f;
        else                                    // The rest of active display pixels:
            rgb_nxt = 12'h2_2_2;                // - fill with dark_gray.
    end
end

endmodule
