`timescale 1 ns / 1 ps

module game_board_ctl (
    input  logic clk,
    input  logic rst,
    input  logic top,
    input  logic bottom,
    input  logic left,
    input  logic right,
    input  logic mouse_left,
    input  logic is_game_on,
    input  logic[2:0] board_size,
    output logic [4:0] board [15:0][15:0]
);

/**
 * Local variables and signals
 */
logic [4:0] board_nxt [15:0][15:0];
logic[30:0] debounce_reg = 0;
logic[30:0] debounce_reg_nxt = 0;
logic selection_x = 0;
logic selection_y = 0;

always_ff @(posedge clk) begin
    if(rst) begin
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                board[i][j] = 5'b0; 
            end
        end
        debounce_reg <= 0;
    end else begin
        board = board_nxt;
        debounce_reg <= debounce_reg_nxt;
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
        board_nxt = board;
        debounce_reg_nxt = debounce_reg;
end


endmodule