/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Waldemar Świder
 *
 * Description:
 * Draw gameboard numbers.
 */
`timescale 1 ns / 1 ps

module game_board_numbers_draw (
    input logic         clk,
    input logic         rst,

    input logic         is_game_on,
    input logic [2:0]   board_size,
    input logic [5:0]   board [15:0][15:0],
    input logic [15:0]  char_pixels,
    input logic [3:0]   selection_x,
    input logic [3:0]   selection_y,

    vga_bus             bus_in,
    vga_bus             bus_out,

    output logic [10:0] address
);

/**
 * Local variables and signals
 */
import vga_pkg::*;

logic [4:0] board_size_squared;
assign board_size_squared = board_size * board_size;

logic [9:0] rect_char_x, rect_char_y, rect_char_width, rect_char_height;
assign rect_char_x = (VISIBLE_WIDTH - SINGLE_RECT_CHAR_WIDTH * board_size_squared) >>1;
assign rect_char_y = (VISIBLE_HEIGHT - SINGLE_RECT_CHAR_HEIGHT * board_size_squared) >>1;
assign rect_char_width = SINGLE_RECT_CHAR_WIDTH * board_size_squared;
assign rect_char_height = SINGLE_RECT_CHAR_HEIGHT * board_size_squared;
			
logic in_horizontal_range, in_vertical_range, is_pixel_active;
assign in_horizontal_range = bus_in.hcount >= rect_char_x && bus_in.hcount < rect_char_x + rect_char_width;
assign in_vertical_range = bus_in.vcount >= rect_char_y && bus_in.vcount < rect_char_y + rect_char_height;
assign is_pixel_active = char_pixels[(board_size<<4 )- (((bus_in.hcount - rect_char_x))&15) ];

logic [3:0] rendered_number_x, rendered_number_y;
assign rendered_number_x = (bus_in.hcount - rect_char_x)>>4;
assign rendered_number_y = (bus_in.vcount - rect_char_y)>>4;

assign address = (((board[rendered_number_y][rendered_number_x]>>1) + 1)<<4) + ((bus_in.vcount - rect_char_y)&15);

logic [11:0] rgb_out_nxt;

/**
 * Internal logic
 */
always_ff @(posedge clk) begin
    if(rst) begin
       bus_out.hcount <= 0;
       bus_out.hsync <= 0;
       bus_out.hblnk <= 0;
       bus_out.vcount <= 0;
       bus_out.vsync <= 0;
       bus_out.vblnk <= 0;
       bus_out.rgb <= 0;
    end else begin
       bus_out.hcount <= bus_in.hcount;
       bus_out.hsync <= bus_in.hsync;
       bus_out.hblnk <= bus_in.hblnk;
       bus_out.vcount <= bus_in.vcount;
       bus_out.vsync <= bus_in.vsync;
       bus_out.vblnk <= bus_in.vblnk;
       bus_out.rgb <= rgb_out_nxt;
    end
end

always_comb begin 
	if(is_game_on && in_horizontal_range && in_vertical_range && is_pixel_active) begin
        if(rendered_number_x == selection_x && rendered_number_y == selection_y) begin
            if(board[rendered_number_y][rendered_number_x]&1'b1) begin
                rgb_out_nxt = FONT_SELECTION_COLOR_LOCKED;
            end else begin
                rgb_out_nxt = FONT_SELECTION_COLOR;
            end
        end else if((rendered_number_x == selection_x) ^ (rendered_number_y == selection_y)) begin
            if(board[rendered_number_y][rendered_number_x]&1'b1) begin
                rgb_out_nxt = FONT_LIGHT_SELECTION_COLOR_LOCKED;
            end else begin
                rgb_out_nxt = FONT_LIGHT_SELECTION_COLOR;
            end
        end else begin
            if(board[rendered_number_y][rendered_number_x]&1'b1) begin
                rgb_out_nxt = FONT_LIGHT_SELECTION_COLOR_LOCKED;
            end else begin
                rgb_out_nxt = FONT_COLOR;
            end
        end
	end else begin
		rgb_out_nxt = bus_in.rgb;
	end;
end;

endmodule