/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Waldemar Świder
 *
 * Description:
 * Draw rectangle.
 */


`timescale 1 ns / 1 ps

module draw_mouse (
    input  logic clk,
    input  logic rst,
    input  logic [11:0] rect_x_position,
    input  logic [11:0] rect_y_position,
    vga_bus bus_in,
    vga_bus bus_out
);

import vga_pkg::*;


/**
 * Local variables and signals
 */

MouseDisplay mouse_display(
    .pixel_clk(clk),
    .xpos(rect_x_position),
    .ypos(rect_y_position),
    .hcount(bus_in.hcount),
    .vcount(bus_in.vcount),
    .blank(bus_in.hblnk || bus_in.vblnk),
    .rgb_in(bus_in.rgb),

    .rgb_out(bus_out.rgb)
);

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
    end else begin
        bus_out.vcount <= bus_in.vcount;
        bus_out.vsync  <= bus_in.vsync;
        bus_out.vblnk  <= bus_in.vblnk;
        bus_out.hcount <= bus_in.hcount;
        bus_out.hsync  <= bus_in.hsync;
        bus_out.hblnk  <= bus_in.hblnk;
    end
end

endmodule
