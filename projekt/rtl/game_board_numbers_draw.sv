`timescale 1 ns / 1 ps

module game_board_numbers_draw (
    input logic clk,
    input logic rst,
    input  logic is_game_on,
    input  logic[2:0] board_size,
    input logic [4:0] board [15:0][15:0],
    input logic [15:0] char_pixels,
    vga_bus bus_in,
    vga_bus bus_out,
    output logic [10:0] address
);

import vga_pkg::*;

localparam  SCREEN_HEIGHT = 768,
			SCREEN_WIDTH = 1024,
			FONT_COLOR = 12'hf_f_f,
            CHAR_WIDTH = 16,
            CHAR_HEIGHT = 16;

logic [15:0] RECT_CHAR_X, RECT_CHAR_Y, RECT_CHAR_WIDTH, RECT_CHAR_HEIGHT;
logic [4:0] board_size_squared;
assign board_size_squared = board_size * board_size;
assign RECT_CHAR_X = (SCREEN_WIDTH - CHAR_WIDTH * board_size_squared) >>1;
assign RECT_CHAR_Y = (SCREEN_HEIGHT - CHAR_HEIGHT * board_size_squared) >>1;
assign RECT_CHAR_WIDTH = CHAR_WIDTH * board_size_squared;
assign RECT_CHAR_HEIGHT = CHAR_HEIGHT * board_size_squared;
			
assign in_horizontal_range = bus_in.hcount >= RECT_CHAR_X && bus_in.hcount < RECT_CHAR_X + RECT_CHAR_WIDTH;
assign in_vertical_range = bus_in.vcount >= RECT_CHAR_Y && bus_in.vcount < RECT_CHAR_Y + RECT_CHAR_HEIGHT;
assign is_pixel_active = char_pixels[(board_size<<4 )- (((bus_in.hcount - RECT_CHAR_X))&15) ];
		
logic [11:0] rgb_out_nxt;

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
		rgb_out_nxt = FONT_COLOR;
	end else begin
		rgb_out_nxt = bus_in.rgb;
	end;
end;

assign address = ((board[(bus_in.vcount - RECT_CHAR_Y)>>4][(bus_in.hcount - RECT_CHAR_X)>>4] + 1)<<4) + ((bus_in.vcount - RECT_CHAR_Y)&15);

endmodule