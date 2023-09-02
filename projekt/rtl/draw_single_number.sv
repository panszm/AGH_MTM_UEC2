/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Waldemar Świder
 *
 * Description:
 * Draw single number character.
 */

`timescale 1 ns / 1 ps

module draw_single_number #(parameter RECT_CHAR_X = 504, parameter RECT_CHAR_Y = 376) (
                           input logic          clk,
                           input logic          rst,
                           
                           input logic          is_game_on,
                           input logic[2:0]     number,

                           vga_bus              bus_in,
                           vga_bus              bus_out,

                           input  logic [15:0]  char_pixels,
                           output logic [10:0]  address
                        );
/**
 * Local variables and signals
 */
import vga_pkg::*;

logic [11:0] rgb_out_nxt;

assign address = (number + 1) *16 + bus_in.vcount - RECT_CHAR_Y;

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
	if(!is_game_on && char_pixels[(16 - (bus_in.hcount - RECT_CHAR_X))%16 ] && bus_in.hcount >= RECT_CHAR_X && bus_in.hcount < (RECT_CHAR_X + SINGLE_RECT_CHAR_WIDTH) && bus_in.vcount >= RECT_CHAR_Y && bus_in.vcount < RECT_CHAR_Y + SINGLE_RECT_CHAR_HEIGHT) begin
		rgb_out_nxt = FONT_COLOR;
	end else begin
		rgb_out_nxt = bus_in.rgb;
	end;
end;

endmodule