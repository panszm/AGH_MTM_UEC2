/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 *
 * Description:
 * The project top module.
 */

`timescale 1 ns / 1 ps

module top_vga (
    input  logic clk,
    input  logic clk100MHz,
    input  logic rst,
    inout  logic ps2_clk,
    inout  logic ps2_data,
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
);


/**
 * Local variables and signals
 */

// VGA signals from timing
wire [10:0] vcount_tim, hcount_tim;
wire vsync_tim, hsync_tim;
wire vblnk_tim, hblnk_tim;

// VGA signals from background
vga_bus bus_bg();

// VGA signals from rect
vga_bus bus_rect();

// VGA signals from mouse
vga_bus bus_mouse();

/**
 * Signals assignments
 */

assign vs = bus_mouse.vsync;
assign hs = bus_mouse.hsync;
assign {r,g,b} = bus_mouse.rgb;


/**
 * Submodules instances
 */

vga_timing u_vga_timing (
    .clk,
    .rst,
    .vcount (vcount_tim),
    .vsync  (vsync_tim),
    .vblnk  (vblnk_tim),
    .hcount (hcount_tim),
    .hsync  (hsync_tim),
    .hblnk  (hblnk_tim)
);

draw_bg u_draw_bg (
    .clk,
    .rst,

    .vcount_in  (vcount_tim),
    .vsync_in   (vsync_tim),
    .vblnk_in   (vblnk_tim),
    .hcount_in  (hcount_tim),
    .hsync_in   (hsync_tim),
    .hblnk_in   (hblnk_tim),

    .bus_out    (bus_bg.OUT)
);

logic mouse_left;
logic [11:0] mouse_x_position, mouse_y_position, rect_x_position, rect_y_position;

MouseCtl mouse_ctl(
    .clk(clk),
    .rst,
    .left(mouse_left),
    .xpos(mouse_x_position),
    .ypos(mouse_y_position),
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data)
);


logic [11:0] img_address, img_rgb;

image_rom u_image_rom (
    .clk,
    .address(img_address),
    .rgb(img_rgb)
);

draw_rect_ctl u_draw_rect_ctl (
    .clk,
    .rst,
    .mouse_left(mouse_left),
    .mouse_x_position(mouse_x_position),
    .mouse_y_position(mouse_y_position),
    .xpos(rect_x_position),
    .ypos(rect_y_position)
);

draw_rect u_draw_rect (
    .clk,
    .rst,

    .rect_x_position(rect_x_position),
    .rect_y_position(rect_y_position),

    .bus_in     (bus_bg.IN),
    .bus_out    (bus_rect.OUT),

    .pixel_addr(img_address),
    .rgb_pixel(img_rgb)
);

draw_mouse u_draw_mouse(
    .clk,
    .rst,

    .rect_x_position(rect_x_position),
    .rect_y_position(rect_y_position),

    .bus_in     (bus_rect.IN),
    .bus_out    (bus_mouse.OUT)
);

endmodule
