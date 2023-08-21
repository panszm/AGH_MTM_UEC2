`timescale 1 ns / 1 ps

module game_board_numbers_draw (
    input logic clk,
    input logic rst,
    input  logic is_game_on,
    input  logic[2:0] board_size,
    input logic [4:0] board [15:0][15:0],
    input logic [7:0] char_pixels,
    vga_bus bus_in,
    vga_bus bus_out,
    output logic [10:0] address
);

import vga_pkg::*;

localparam  SCREEN_HEIGHT = 768,
			SCREEN_WIDTH = 1024,
			FONT_COLOR = 12'hf_f_f,
            CHAR_WIDTH = 8,
            CHAR_HEIGHT = 16;

logic [15:0] RECT_CHAR_X, RECT_CHAR_Y, RECT_CHAR_WIDTH, RECT_CHAR_HEIGHT;
assign RECT_CHAR_X = (SCREEN_WIDTH - CHAR_WIDTH * board_size * board_size) >>1;
assign RECT_CHAR_Y = (SCREEN_HEIGHT - CHAR_HEIGHT * board_size * board_size) >>1;
assign RECT_CHAR_WIDTH = CHAR_WIDTH * board_size * board_size;
assign RECT_CHAR_HEIGHT = CHAR_HEIGHT * board_size * board_size;
			
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
    // if(is_game_on && bus_in.hcount > 400) begin
    // 	rgb_out_nxt = FONT_COLOR;
	// end else begin
	// 	rgb_out_nxt = bus_in.rgb;
    // end
	if(is_game_on && char_pixels[(4*board_size - bus_in.hcount[2:0])%8 ] && bus_in.hcount >= RECT_CHAR_X && bus_in.hcount < RECT_CHAR_X + RECT_CHAR_WIDTH && bus_in.vcount >= RECT_CHAR_Y && bus_in.vcount < RECT_CHAR_Y + RECT_CHAR_HEIGHT) begin
		rgb_out_nxt = FONT_COLOR;
	end else begin
		rgb_out_nxt = bus_in.rgb;
	end;
end;

assign address = (board[(bus_in.vcount - RECT_CHAR_Y)/16][(bus_in.hcount - RECT_CHAR_X)/8] + 1) *16 + (bus_in.vcount - RECT_CHAR_Y)%16;

endmodule