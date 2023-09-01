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
    if (vblnk_in || hblnk_in) begin         
        rgb_nxt = 12'h0_0_0;         
    end else begin                      
        if(vcount_in>>3 == 6 && (hcount_in>>3 == 53 || hcount_in>>3 == 54 || hcount_in>>3 == 55)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 7  && (hcount_in>>3 == 53)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 8 && (hcount_in>>3 == 53 || hcount_in>>3 == 54 || hcount_in>>3 == 55)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 9 && (hcount_in>>3 == 55)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 10 && (hcount_in>>3 == 53 || hcount_in>>3 == 54 || hcount_in>>3 == 55)) rgb_nxt = 12'h4_4_4;

        else if(vcount_in>>3 == 6 && (hcount_in>>3 == 57 || hcount_in>>3 == 59)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 7 && (hcount_in>>3 == 57 || hcount_in>>3 == 59)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 8 && (hcount_in>>3 == 57 || hcount_in>>3 == 59)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 9 && (hcount_in>>3 == 57 || hcount_in>>3 == 59)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 10 && (hcount_in>>3 == 57 || hcount_in>>3 == 58 || hcount_in>>3 == 59)) rgb_nxt = 12'h4_4_4;

        else if(vcount_in>>3 == 6 && (hcount_in>>3 == 61 || hcount_in>>3 == 62)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 7 && (hcount_in>>3 == 61 || hcount_in>>3 == 63)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 8 && (hcount_in>>3 == 61 || hcount_in>>3 == 63)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 9 && (hcount_in>>3 == 61 || hcount_in>>3 == 63)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 10 && (hcount_in>>3 == 61 || hcount_in>>3 == 62)) rgb_nxt = 12'h4_4_4;

        else if(vcount_in>>3 == 6 && (hcount_in>>3 == 65 || hcount_in>>3 == 66 || hcount_in>>3 == 67)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 7 && (hcount_in>>3 == 65 || hcount_in>>3 == 67)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 8 && (hcount_in>>3 == 65 || hcount_in>>3 == 67)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 9 && (hcount_in>>3 == 65 || hcount_in>>3 == 67)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 10 && (hcount_in>>3 == 65 || hcount_in>>3 == 66 || hcount_in>>3 == 67)) rgb_nxt = 12'h4_4_4;

        else if(vcount_in>>3 == 6 && (hcount_in>>3 == 69 || hcount_in>>3 == 71)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 7 && (hcount_in>>3 == 69 || hcount_in>>3 == 71)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 8 && (hcount_in>>3 == 69 || hcount_in>>3 == 70)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 9 && (hcount_in>>3 == 69 || hcount_in>>3 == 71)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 10 && (hcount_in>>3 == 69 || hcount_in>>3 == 71)) rgb_nxt = 12'h4_4_4;

        else if(vcount_in>>3 == 6 && (hcount_in>>3 == 73 || hcount_in>>3 == 75)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 7 && (hcount_in>>3 == 73 || hcount_in>>3 == 75)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 8 && (hcount_in>>3 == 73 || hcount_in>>3 == 75)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 9 && (hcount_in>>3 == 73 || hcount_in>>3 == 75)) rgb_nxt = 12'h4_4_4;
        else if(vcount_in>>3 == 10 && (hcount_in>>3 == 73 || hcount_in>>3 == 74 || hcount_in>>3 == 75)) rgb_nxt = 12'h4_4_4;


        else rgb_nxt = 12'h2_2_2;
    end
end

endmodule
