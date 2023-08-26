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
    output logic [5:0] board [15:0][15:0],
    output logic[3:0] selection_x,
    output logic[3:0] selection_y
);

/**
 * Local variables and signals
 */
logic [5:0] board_nxt [15:0][15:0];
logic[26:0] debounce_reg = 0;
logic[26:0] debounce_reg_nxt = 0;
logic[3:0] selection_x_nxt = 0;
logic[3:0] selection_y_nxt = 0;
logic [4:0] board_size_squared;
assign board_size_squared = board_size * board_size;

always_ff @(posedge clk) begin
    if(rst) begin
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                board[i][j] <= 5'b11; 
            end
        end
        debounce_reg <= 0;
        selection_x <= 0;
        selection_y <= 0;
    end else begin
        board = board_nxt;
        debounce_reg <= debounce_reg_nxt;
        selection_x <= selection_x_nxt;
        selection_y <= selection_y_nxt;
    end
end

always_comb begin
    if(is_game_on) begin
        if(top && debounce_reg == 0) begin
            debounce_reg_nxt = 20000000;
            if(selection_y > 0 ) begin
                selection_y_nxt = selection_y - 1;
            end else begin
                selection_y_nxt = 0;
            end
            selection_x_nxt = selection_x;
        end else if(bottom && debounce_reg == 0) begin
            debounce_reg_nxt = 20000000;
            if(selection_y < (board_size_squared - 1) ) begin
                selection_y_nxt = selection_y + 1;
            end else begin
                selection_y_nxt = (board_size_squared - 1);
            end
            selection_x_nxt = selection_x;
        end else if(left && debounce_reg == 0) begin
            debounce_reg_nxt = 20000000;
            if(selection_x > 0) begin
                selection_x_nxt = selection_x - 1;
            end else begin
                selection_x_nxt = 0;
            end
            selection_y_nxt = selection_y;
        end else if(right && debounce_reg == 0) begin
            debounce_reg_nxt = 20000000;
            if(selection_x < (board_size_squared - 1) ) begin
                selection_x_nxt = selection_x + 1;
            end else begin
                selection_x_nxt = (board_size_squared - 1);
            end
            selection_y_nxt = selection_y;
        end else begin
            if(debounce_reg>0) begin
                debounce_reg_nxt = debounce_reg - 1;
            end else begin
                debounce_reg_nxt = debounce_reg;
            end
            selection_x_nxt = selection_x;
            selection_y_nxt = selection_y;
        end
        board_nxt = board;
    end else begin
        debounce_reg_nxt = debounce_reg;
        selection_x_nxt = selection_x;
        selection_y_nxt = selection_y;
        board_nxt = board;
    end
end


endmodule