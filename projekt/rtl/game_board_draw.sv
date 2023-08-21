`timescale 1 ns / 1 ps

module game_board_draw (
    input  logic clk,
    input  logic rst,
    input  logic is_game_on,
    input  logic[2:0] board_size,
    input logic [4:0] board [15:0][15:0],
    vga_bus bus_in,
    vga_bus bus_out
);

/**
 * Local variables and signals
 */
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
        // if(mouse_left) begin
        // end else if(top) begin
        // end else if(bottom) begin
        // end else if(left) begin
        // end else if(right) begin
        // end else begin
        // end
        rgb_out_nxt <= bus_in.rgb;
end


endmodule