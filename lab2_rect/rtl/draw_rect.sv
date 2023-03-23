/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Waldemar Świder
 *
 * Description:
 * Draw rectangle.
 */


`timescale 1 ns / 1 ps

module draw_rect (
    input  logic clk,
    input  logic rst,

    input  logic [10:0] vcount_in,
    input  logic        vsync_in,
    input  logic        vblnk_in,
    input  logic [10:0] hcount_in,
    input  logic        hsync_in,
    input  logic        hblnk_in,

    input  logic [11:0] rgb_in,

    output logic [10:0] vcount_out,
    output logic        vsync_out,
    output logic        vblnk_out,
    output logic [10:0] hcount_out,
    output logic        hsync_out,
    output logic        hblnk_out,

    output logic [11:0] rgb_out
);

import vga_pkg::*;


/**
 * Local variables and signals
 */
logic [11:0] rgb_nxt;

localparam RECT_X_POSITION = 50,
           RECT_Y_POSITION = 50,
           RECT_WIDTH = 50,
           RECT_HEIGHT = 100,
           RECT_COLOR = 12'hb_9_b


/**
 * Internal logic
 */

always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        vcount_out <= '0;
        vsync_out  <= '0;
        vblnk_out  <= '0;
        hcount_out <= '0;
        hsync_out  <= '0;
        hblnk_out  <= '0;
        rgb_out    <= '0;
    end else begin
        vcount_out <= vcount_in;
        vsync_out  <= vsync_in;
        vblnk_out  <= vblnk_in;
        hcount_out <= hcount_in;
        hsync_out  <= hsync_in;
        hblnk_out  <= hblnk_in;
        rgb_out    <= rgb_nxt;
    end
end

always_comb begin : bg_comb_blk
    if (!vblnk_in && !hblnk_in && hcount_in >= RECT_X_POSITION && hcount_in <= (RECT_X_POSITION + RECT_WIDTH) && vcount_in >= RECT_Y_POSITION && vcount_in <= (RECT_Y_POSITION + RECT_HEIGHT)) begin              // - make it it black.                              // Active region:
        rgb_nxt = RECT_COLOR;
    end else begin
        rgb_nxt = rgb_in;
    end

end

endmodule
