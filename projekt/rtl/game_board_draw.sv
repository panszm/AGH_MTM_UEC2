/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Waldemar Świder
 *
 * Description:
 * Draw game board (separating lines) and VICTORY label.
 */
`timescale 1 ns / 1 ps

module game_board_draw (
    input logic         clk,
    input logic         rst,

    input logic         is_game_on,
    input logic[2:0]    board_size,
    input logic         incorrect,
    input logic         victory,

    vga_bus             bus_in,
    vga_bus             bus_out
);

/**
 * Local variables and signals
 */
import vga_pkg::*;


logic [9:0] rect_char_x, rect_char_y, rect_char_width, rect_char_height;
logic [4:0] board_size_squared;

assign board_size_squared = board_size * board_size;
assign rect_char_x = (VISIBLE_WIDTH - SINGLE_RECT_CHAR_WIDTH * board_size_squared) >>1;
assign rect_char_y = (VISIBLE_HEIGHT - SINGLE_RECT_CHAR_HEIGHT * board_size_squared) >>1;
assign rect_char_width = SINGLE_RECT_CHAR_WIDTH * board_size_squared;
assign rect_char_height = SINGLE_RECT_CHAR_HEIGHT * board_size_squared;

logic in_horizontal_range, in_vertical_range;

assign in_horizontal_range =  bus_in.hcount > rect_char_x && bus_in.hcount < (rect_char_x + rect_char_width);
assign in_vertical_range = bus_in.vcount > rect_char_y && bus_in.vcount < (rect_char_y + rect_char_height);

logic is_pixel_active_horizontally, is_pixel_active_vertically;
logic [7:0] chars_column_count, chars_row_count, line_interval;

assign line_interval = board_size<<4;
assign chars_column_count = (bus_in.hcount - rect_char_x);
assign is_pixel_active_horizontally = (chars_column_count%line_interval) == 0;
assign chars_row_count = (bus_in.vcount - rect_char_y);
assign is_pixel_active_vertically =  (chars_row_count%line_interval) == 0;

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
    if(is_game_on && in_horizontal_range && in_vertical_range && (is_pixel_active_horizontally || is_pixel_active_vertically)) begin
        if(incorrect) begin
            rgb_out_nxt = LINES_COLOR_INCORRECT;
        end else if(victory) begin
            rgb_out_nxt = LINES_COLOR_VICTORY;
        end else begin
            rgb_out_nxt = LINES_COLOR;
        end
    end else if(victory) begin
        if(bus_in.vcount == 550 && (bus_in.hcount == 480 || bus_in.hcount == 481 || bus_in.hcount == 486 || bus_in.hcount == 487)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 551 && (bus_in.hcount == 480 || bus_in.hcount == 481 || bus_in.hcount == 486 || bus_in.hcount == 487)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 552 && (bus_in.hcount == 480 || bus_in.hcount == 481 || bus_in.hcount == 486 || bus_in.hcount == 487)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 553 && (bus_in.hcount == 480 || bus_in.hcount == 481 || bus_in.hcount == 486 || bus_in.hcount == 487)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 554 && (bus_in.hcount == 480 || bus_in.hcount == 481 || bus_in.hcount == 486 || bus_in.hcount == 487)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 555 && (bus_in.hcount == 480 || bus_in.hcount == 481 || bus_in.hcount == 486 || bus_in.hcount == 487)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 556 && (bus_in.hcount == 480 || bus_in.hcount == 481 || bus_in.hcount == 486 || bus_in.hcount == 487)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 557 && (bus_in.hcount == 481 || bus_in.hcount == 482 || bus_in.hcount == 485 || bus_in.hcount == 486)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 558 && (bus_in.hcount == 482 || bus_in.hcount == 483 || bus_in.hcount == 484 || bus_in.hcount == 485)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 559 && (bus_in.hcount == 483 || bus_in.hcount == 484)) rgb_out_nxt = LINES_COLOR_VICTORY;

        else if(bus_in.vcount == 550 && (bus_in.hcount == 490 || bus_in.hcount == 491 || bus_in.hcount == 492 || bus_in.hcount == 493)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 551 && (bus_in.hcount == 491 || bus_in.hcount == 492)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 552 && (bus_in.hcount == 491 || bus_in.hcount == 492)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 553 && (bus_in.hcount == 491 || bus_in.hcount == 492)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 554 && (bus_in.hcount == 491 || bus_in.hcount == 492)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 555 && (bus_in.hcount == 491 || bus_in.hcount == 492)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 556 && (bus_in.hcount == 491 || bus_in.hcount == 492)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 557 && (bus_in.hcount == 491 || bus_in.hcount == 492)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 558 && (bus_in.hcount == 491 || bus_in.hcount == 492)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 559 && (bus_in.hcount == 490 || bus_in.hcount == 491 || bus_in.hcount == 492 || bus_in.hcount == 493)) rgb_out_nxt = LINES_COLOR_VICTORY;

        else if(bus_in.vcount == 550 && (bus_in.hcount == 498 || bus_in.hcount == 499 || bus_in.hcount == 500 || bus_in.hcount == 501)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 551 && (bus_in.hcount == 497 || bus_in.hcount == 498 || bus_in.hcount == 501 || bus_in.hcount == 502)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 552 && (bus_in.hcount == 496 || bus_in.hcount == 497 || bus_in.hcount == 502)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 553 && (bus_in.hcount == 496 || bus_in.hcount == 497)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 554 && (bus_in.hcount == 496 || bus_in.hcount == 497)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 555 && (bus_in.hcount == 496 || bus_in.hcount == 497)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 556 && (bus_in.hcount == 496 || bus_in.hcount == 497)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 557 && (bus_in.hcount == 496 || bus_in.hcount == 497 || bus_in.hcount == 502)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 558 && (bus_in.hcount == 497 || bus_in.hcount == 498 || bus_in.hcount == 501 || bus_in.hcount == 502)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 559 && (bus_in.hcount == 498 || bus_in.hcount == 499 || bus_in.hcount == 500 || bus_in.hcount == 501)) rgb_out_nxt = LINES_COLOR_VICTORY;

        else if(bus_in.vcount == 550 && (bus_in.hcount >= 504 && bus_in.hcount <= 511)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 551 && (bus_in.hcount == 504 || bus_in.hcount == 505 || bus_in.hcount == 507 || bus_in.hcount == 508 || bus_in.hcount == 510 || bus_in.hcount == 511)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 552 && (bus_in.hcount == 504 || bus_in.hcount == 507 || bus_in.hcount == 508 || bus_in.hcount == 511)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 553 && (bus_in.hcount == 507 || bus_in.hcount == 508)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 554 && (bus_in.hcount == 507 || bus_in.hcount == 508)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 555 && (bus_in.hcount == 507 || bus_in.hcount == 508)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 556 && (bus_in.hcount == 507 || bus_in.hcount == 508)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 557 && (bus_in.hcount == 507 || bus_in.hcount == 508)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 558 && (bus_in.hcount == 507 || bus_in.hcount == 508)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 559 && (bus_in.hcount == 506 || bus_in.hcount == 507 || bus_in.hcount == 508 || bus_in.hcount == 509)) rgb_out_nxt = LINES_COLOR_VICTORY;

        else if(bus_in.vcount == 550 && (bus_in.hcount == 513 || bus_in.hcount == 514 || bus_in.hcount == 515 || bus_in.hcount == 516 || bus_in.hcount == 517)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 551 && (bus_in.hcount == 512 || bus_in.hcount == 513 || bus_in.hcount == 517 || bus_in.hcount == 518)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 552 && (bus_in.hcount == 512 || bus_in.hcount == 513 || bus_in.hcount == 517 || bus_in.hcount == 518)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 553 && (bus_in.hcount == 512 || bus_in.hcount == 513 || bus_in.hcount == 517 || bus_in.hcount == 518)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 554 && (bus_in.hcount == 512 || bus_in.hcount == 513 || bus_in.hcount == 517 || bus_in.hcount == 518)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 555 && (bus_in.hcount == 512 || bus_in.hcount == 513 || bus_in.hcount == 517 || bus_in.hcount == 518)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 556 && (bus_in.hcount == 512 || bus_in.hcount == 513 || bus_in.hcount == 517 || bus_in.hcount == 518)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 557 && (bus_in.hcount == 512 || bus_in.hcount == 513 || bus_in.hcount == 517 || bus_in.hcount == 518)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 558 && (bus_in.hcount == 512 || bus_in.hcount == 513 || bus_in.hcount == 517 || bus_in.hcount == 518)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 559 && (bus_in.hcount == 513 || bus_in.hcount == 514 || bus_in.hcount == 515 || bus_in.hcount == 516 || bus_in.hcount == 517)) rgb_out_nxt = LINES_COLOR_VICTORY;

        else if(bus_in.vcount == 550 && (bus_in.hcount == 520 || bus_in.hcount == 521 || bus_in.hcount == 522 || bus_in.hcount == 523 || bus_in.hcount == 524 || bus_in.hcount == 525)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 551 && (bus_in.hcount == 521 || bus_in.hcount == 522 || bus_in.hcount == 525 || bus_in.hcount == 526)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 552 && (bus_in.hcount == 521 || bus_in.hcount == 522 || bus_in.hcount == 525 || bus_in.hcount == 526)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 553 && (bus_in.hcount == 521 || bus_in.hcount == 522 || bus_in.hcount == 525 || bus_in.hcount == 526)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 554 && (bus_in.hcount == 521 || bus_in.hcount == 522 || bus_in.hcount == 523 || bus_in.hcount == 524 || bus_in.hcount == 525)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 555 && (bus_in.hcount == 521 || bus_in.hcount == 522 ||  bus_in.hcount == 524 || bus_in.hcount == 525)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 556 && (bus_in.hcount == 521 || bus_in.hcount == 522 || bus_in.hcount == 525 || bus_in.hcount == 526)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 557 && (bus_in.hcount == 521 || bus_in.hcount == 522 || bus_in.hcount == 525 || bus_in.hcount == 526)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 558 && (bus_in.hcount == 521 || bus_in.hcount == 522 || bus_in.hcount == 525 || bus_in.hcount == 526)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 559 && (bus_in.hcount == 520 || bus_in.hcount == 521 || bus_in.hcount == 522 || bus_in.hcount == 525 || bus_in.hcount == 526)) rgb_out_nxt = LINES_COLOR_VICTORY;

        else if(bus_in.vcount == 550 && (bus_in.hcount == 528 || bus_in.hcount == 529 ||  bus_in.hcount == 534 || bus_in.hcount == 535)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 551 && (bus_in.hcount == 528 || bus_in.hcount == 529 ||  bus_in.hcount == 534 || bus_in.hcount == 535)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 552 && (bus_in.hcount == 528 || bus_in.hcount == 529 ||  bus_in.hcount == 534 || bus_in.hcount == 535)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 553 && (bus_in.hcount == 529 || bus_in.hcount == 530 ||  bus_in.hcount == 533 || bus_in.hcount == 534)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 554 && (bus_in.hcount == 530 || bus_in.hcount == 531 ||  bus_in.hcount == 532 || bus_in.hcount == 533)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 555 && (bus_in.hcount == 531 ||  bus_in.hcount == 532)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 556 && (bus_in.hcount == 531 ||  bus_in.hcount == 532)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 557 && (bus_in.hcount == 531 ||  bus_in.hcount == 532)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 558 && (bus_in.hcount == 531 ||  bus_in.hcount == 532)) rgb_out_nxt = LINES_COLOR_VICTORY;
        else if(bus_in.vcount == 559 && (bus_in.hcount == 530 || bus_in.hcount == 531 ||  bus_in.hcount == 532 || bus_in.hcount == 533)) rgb_out_nxt = LINES_COLOR_VICTORY;

        else rgb_out_nxt = bus_in.rgb;
    end else begin
        rgb_out_nxt = bus_in.rgb;
    end
end


endmodule