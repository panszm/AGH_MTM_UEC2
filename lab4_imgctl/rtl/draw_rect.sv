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
    input  logic [11:0] rect_x_position,
    input  logic [11:0] rect_y_position,
    input  logic [11:0] rgb_pixel,
    output logic [11:0] pixel_addr,
    vga_bus bus_in,
    vga_bus bus_out
);

import vga_pkg::*;


/**
 * Local variables and signals
 */
logic [11:0] rgb_nxt;
logic [11:0] vcount_nxt, hcount_nxt;
logic vblnk_nxt, hblnk_nxt, vsync_nxt, hsync_nxt;
logic [5:0] pixel_addr_x, pixel_addr_y;

localparam RECT_WIDTH = 48,
           RECT_HEIGHT = 64,
           RECT_COLOR = 12'hb_9_b;


/**
 * Internal logic
 */
// always_ff @(posedge clk) begin
//     if (rst) begin
//         vcount_nxt <= '0;
//         hcount_nxt <= '0;
//         vblnk_nxt <= '0;
//         hblnk_nxt <= '0;
//         vsync_nxt <= '0;
//         hsync_nxt <= '0;
//     end else begin
//         vcount_nxt <= bus_in.vcount;
//         hcount_nxt <= bus_in.hcount;
//         vblnk_nxt <= bus_in.vblnk;
//         hblnk_nxt <= bus_in.hblnk;
//         vsync_nxt <= bus_in.vsync;
//         hsync_nxt <= bus_in.hsync;
//     end
// end

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
