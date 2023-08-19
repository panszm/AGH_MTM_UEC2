`timescale 1 ns / 1 ps

module draw_rect_char (
    input logic clk,
    input logic rst,

    vga_bus bus_in,
    vga_bus bus_out,
    input logic [7:0] char_pixels,
    output logic [10:0] address
);

import vga_pkg::*;

localparam  SCREEN_HEIGHT = 600,
			SCREEN_WIDTH = 800,
			FONT_COLOR = 12'h0,
            RECT_CHAR_X = 0,
            RECT_CHAR_Y = 0,
            RECT_CHAR_WIDTH = 128,
            RECT_CHAR_HEIGHT = 128;
			
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
	if(char_pixels[(8 - bus_in.hcount[2:0])%8 ] && bus_in.hcount >= RECT_CHAR_X && bus_in.hcount < RECT_CHAR_X + RECT_CHAR_WIDTH && bus_in.vcount >= RECT_CHAR_Y && bus_in.vcount < RECT_CHAR_Y + RECT_CHAR_HEIGHT) begin
		rgb_out_nxt = FONT_COLOR;
	end else begin
		rgb_out_nxt = bus_in.rgb;
	end;
end;

assign address = {(((bus_in.hcount-RECT_CHAR_X)>>3)%16 + (bus_in.vcount-RECT_CHAR_Y) - (bus_in.vcount-RECT_CHAR_Y)%16)%128, (bus_in.vcount[3:0] - RECT_CHAR_Y[3:0])& 4'b1111};

endmodule