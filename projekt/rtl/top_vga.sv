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
    input  logic rst,
    input  logic top,
    input  logic left,
    input  logic bottom,
    input  logic right,
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

vga_bus bus_board();
vga_bus bus_board_numbers();

vga_bus bus_out();
/**
 * Signals assignments
 */

assign vs = bus_out.vsync;
assign hs = bus_out.hsync;
assign {r,g,b} = bus_out.rgb;

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

logic[2:0] board_size;
logic is_game_on;

game_menu u_game_menu(
    .clk,
    .rst,
    .top,
    .bottom,
    .mouse_left,
    .board_size,
    .is_game_on
);

logic[15:0] char_pixels;
logic [10:0] char_address;

draw_single_num u_draw_single_num(
    .clk,
    .rst,
    .is_game_on,
    .board_size,

    .bus_in(bus_bg.IN),
    .bus_out(bus_board.OUT),
    .char_pixels,
    .address(char_address)
);

font_rom_numerical u_font_rom_numerical(
    .clk,
    .addr(char_address),
    .char_line_pixels(char_pixels)
);

logic [4:0] board [15:0][15:0];

game_board_ctl u_game_board_ctl(
    .clk,
    .rst,
    .top,
    .bottom,
    .left,
    .right,
    .mouse_left,
    .is_game_on,
    .board_size,
    .board
);

game_board_draw u_game_board_draw(
    .clk,
    .rst,
    .is_game_on,
    .board_size,
    .board,
    .bus_in(bus_board.IN),
    .bus_out(bus_board_numbers.OUT)
);

logic[15:0] char_pixels_2;
logic [10:0] char_address_2;

game_board_numbers_draw u_game_board_numbers_draw(
    .clk,
    .rst,
    .is_game_on,
    .board_size,
    .board,
    .char_pixels(char_pixels_2),
    .bus_in(bus_board_numbers.IN),
    .bus_out(bus_out.OUT),
    .address(char_address_2)
);

font_rom_numerical u2_font_rom_numerical(
    .clk,
    .addr(char_address_2),
    .char_line_pixels(char_pixels_2)
);

endmodule
