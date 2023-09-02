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

wire [10:0] vcount_tim, hcount_tim;
wire vsync_tim, hsync_tim;
wire vblnk_tim, hblnk_tim;

logic mouse_left, mouse_right;
logic [11:0] mouse_x_position;

logic [5:0] board [15:0][15:0];
logic [5:0] selected_board [15:0][15:0];
logic [5:0] selected_board_complete [15:0][15:0];
logic [3:0] selection_x, selection_y;

logic is_game_on;
logic[2:0] board_size;
logic[1:0] seed;
logic[2:0] lvl;

logic[15:0] char_pixels_board_size;
logic [10:0] char_address_board_size;
logic[15:0] char_pixels_board_numbers;
logic [10:0] char_address_board_numbers;
logic[15:0] char_pixels_lvl;
logic [10:0] char_address_lvl;

logic incorrect, victory;
logic victory_rst;


vga_bus bus_bg();

vga_bus bus_menu();
vga_bus bus_num();
vga_bus bus_board();
vga_bus bus_board_numbers();

vga_bus bus_out();

/**
 * Signals assignments
 */

assign vs = bus_out.vsync;
assign hs = bus_out.hsync;
assign {r,g,b} = bus_out.rgb;

assign seed = mouse_x_position % 3;
assign rst_comb = rst || victory_rst;

/**
 * Submodules instances
 */

MouseCtl mouse_ctl(
    .clk,
    .rst,
    .left(mouse_left),
    .right(mouse_right),
    .xpos(mouse_x_position),
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data)
);

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

game_menu_ctl u_game_menu_ctl(
    .clk,
    .rst(rst_comb),

    .top,
    .bottom,
    .left,
    .right,
    .mouse_left,

    .board_size,
    .lvl,
    .is_game_on
);

game_menu_draw u_game_menu_draw(
    .clk,
    .rst(rst_comb),

    .is_game_on,

    .bus_in(bus_bg.IN),
    .bus_out(bus_menu.OUT)
);

draw_single_number u_draw_single_number_size(
    .clk,
    .rst(rst_comb),

    .is_game_on,
    .number(board_size),

    .bus_in(bus_menu.IN),
    .bus_out(bus_num.OUT),

    .char_pixels(char_pixels_board_size),
    .address(char_address_board_size)
);

font_rom_numerical u_font_rom_numerical_size(
    .clk,

    .addr(char_address_board_size),
    .char_line_pixels(char_pixels_board_size)
);


draw_single_number #(504, 392) u_draw_single_number_lvl (
    .clk,
    .rst(rst_comb),

    .is_game_on,
    .number(lvl),

    .bus_in(bus_num.IN),
    .bus_out(bus_board.OUT),

    .char_pixels(char_pixels_lvl),
    .address(char_address_lvl)
);

font_rom_numerical u_font_rom_numerical_lvl(
    .clk,

    .addr(char_address_lvl),
    .char_line_pixels(char_pixels_lvl)
);

game_board_select u_game_board_select(
    .clk,
    .rst(rst_comb),

    .board_size,
    .lvl,
    .seed,
    .is_game_on,

    .selected_board,
    .selected_board_complete
);

game_board_ctl u_game_board_ctl(
    .clk,
    .rst(rst_comb),

    .top,
    .bottom,
    .left,
    .right,
    .mouse_left,
    .mouse_right,

    .is_game_on,
    .board_size,
    .selected_board,
    .selected_board_complete,

    .board,
    .selection_x,
    .selection_y,
    .incorrect,
    .victory,
    .victory_rst
);

game_board_draw u_game_board_draw(
    .clk,
    .rst(rst_comb),

    .is_game_on,
    .board_size,
    .incorrect,
    .victory,

    .bus_in(bus_board.IN),
    .bus_out(bus_board_numbers.OUT)
);

game_board_numbers_draw u_game_board_numbers_draw(
    .clk,
    .rst(rst_comb),

    .is_game_on,
    .board_size,
    .board,
    .char_pixels(char_pixels_board_numbers),
    .selection_x,
    .selection_y,

    .bus_in(bus_board_numbers.IN),
    .bus_out(bus_out.OUT),

    .address(char_address_board_numbers)
);

font_rom_numerical u2_font_rom_numerical(
    .clk,
    
    .addr(char_address_board_numbers),
    .char_line_pixels(char_pixels_board_numbers)
);

endmodule
