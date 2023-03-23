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
    vga_bus bus_in,
    vga_bus bus_out
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
           RECT_COLOR = 12'hb_9_b;


/**
 * Internal logic
 */

always_ff @(posedge clk) begin
    if (rst) begin
        bus_out.vcount <= '0;
        bus_out.vsync  <= '0;
        bus_out.vblnk  <= '0;
        bus_out.hcount <= '0;
        bus_out.hsync  <= '0;
        bus_out.hblnk  <= '0;
        bus_out.rgb    <= '0;
    end else begin
        bus_out.vcount <= bus_in.vcount;
        bus_out.vsync  <= bus_in.vsync;
        bus_out.vblnk  <= bus_in.vblnk;
        bus_out.hcount <= bus_in.hcount;
        bus_out.hsync  <= bus_in.hsync;
        bus_out.hblnk  <= bus_in.hblnk;
        bus_out.rgb    <= rgb_nxt;
    end
end

always_comb begin
    if (!bus_in.vblnk && !bus_in.hblnk && bus_in.hcount >= RECT_X_POSITION && bus_in.hcount <= (RECT_X_POSITION + RECT_WIDTH) && bus_in.vcount >= RECT_Y_POSITION && bus_in.vcount <= (RECT_Y_POSITION + RECT_HEIGHT)) begin              // - make it it black.                              // Active region:
        rgb_nxt = RECT_COLOR;
    end else begin
        rgb_nxt = bus_in.rgb;
    end

end

endmodule
