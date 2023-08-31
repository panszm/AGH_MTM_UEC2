`timescale 1 ns / 1 ps

module game_board_draw (
    input  logic clk,
    input  logic rst,
    input  logic is_game_on,
    input  logic[2:0] board_size,
    vga_bus bus_in,
    vga_bus bus_out,
    input logic incorrect
);

/**
 * Local variables and signals
 */
localparam  SCREEN_HEIGHT = 768,
			SCREEN_WIDTH = 1024,
			FONT_COLOR = 12'h7_7_7,
			FONT_COLOR_INCORRECT = 12'hf_7_7,
            CHAR_WIDTH = 16,
            CHAR_HEIGHT = 16;
logic [9:0] RECT_CHAR_X, RECT_CHAR_Y, RECT_CHAR_WIDTH, RECT_CHAR_HEIGHT;
logic [4:0] board_size_squared;
logic is_pixel_active_horizontally, is_pixel_active_vertically;
logic [7:0] chars_column_count, chars_row_count, line_interval;
assign board_size_squared = board_size * board_size;
assign RECT_CHAR_X = (SCREEN_WIDTH - CHAR_WIDTH * board_size_squared) >>1;
assign RECT_CHAR_Y = (SCREEN_HEIGHT - CHAR_HEIGHT * board_size_squared) >>1;
assign RECT_CHAR_WIDTH = CHAR_WIDTH * board_size_squared;
assign RECT_CHAR_HEIGHT = CHAR_HEIGHT * board_size_squared;

assign in_horizontal_range =  bus_in.hcount > RECT_CHAR_X && bus_in.hcount < (RECT_CHAR_X + RECT_CHAR_WIDTH);
assign in_vertical_range = bus_in.vcount > RECT_CHAR_Y && bus_in.vcount < (RECT_CHAR_Y + RECT_CHAR_HEIGHT);

assign line_interval = board_size<<4;
assign chars_column_count = (bus_in.hcount - RECT_CHAR_X);
assign is_pixel_active_horizontally = (chars_column_count%line_interval) == 0;
assign chars_row_count = (bus_in.vcount - RECT_CHAR_Y);
assign is_pixel_active_vertically =  (chars_row_count%line_interval) == 0;

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
    if(is_game_on && in_horizontal_range && in_vertical_range && (is_pixel_active_horizontally || is_pixel_active_vertically)) begin
        if(incorrect) begin
            rgb_out_nxt = FONT_COLOR_INCORRECT;
        end else begin
            rgb_out_nxt = FONT_COLOR;
        end
    end else begin
        rgb_out_nxt = bus_in.rgb;
    end
end


endmodule