/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Waldemar Świder
 *
 * Description:
 * Sudoku board logic.
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
localparam RECT_WIDTH = 48,
           RECT_HEIGHT = 64,
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
    if (bus_in.hcount >= rect_x_position && bus_in.hcount < (rect_x_position + RECT_WIDTH) && bus_in.vcount >= rect_y_position && bus_in.vcount < (rect_y_position + RECT_HEIGHT)) begin   
        rgb_nxt = rgb_pixel;
    end else begin
        rgb_nxt = bus_in.rgb;
    end
end

assign pixel_addr_y = bus_in.vcount - rect_y_position;
assign pixel_addr_x = (bus_in.hcount - rect_x_position +1)%FULL_WIDTH ;
assign pixel_addr = {pixel_addr_y, pixel_addr_x};

endmodule
