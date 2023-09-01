`timescale 1 ns / 1 ps

module game_board_ctl (
    input  logic clk,
    input  logic rst,
    input  logic top,
    input  logic bottom,
    input  logic left,
    input  logic right,
    input  logic mouse_left,
    input  logic mouse_right,
    input  logic is_game_on,
    input  logic[2:0] board_size,
    input logic [5:0] selected_board [15:0][15:0],
    input logic [5:0] selected_board_complete [15:0][15:0],
    output logic [5:0] board [15:0][15:0],
    output logic[3:0] selection_x,
    output logic[3:0] selection_y,
    output logic incorrect,
    output logic victory
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
logic incorrect_nxt;
logic victory_nxt;
assign board_size_squared = board_size * board_size;

always_ff @(posedge clk) begin
    if(rst) begin
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                board[i][j] <= 6'b0 ; 
            end
        end
        debounce_reg <= 0;
        selection_x <= 0;
        selection_y <= 0;
        incorrect <= 0;
        victory <= 0;
    end else begin
        board <= board_nxt;
        debounce_reg <= debounce_reg_nxt;
        selection_x <= selection_x_nxt;
        selection_y <= selection_y_nxt;
        incorrect <= incorrect_nxt;
        victory <= victory_nxt;
    end
end

always_comb begin
    if(is_game_on) begin
        if(mouse_left && debounce_reg == 0) begin
            debounce_reg_nxt = 20000000;
            selection_x_nxt = selection_x;
            selection_y_nxt = selection_y;
            board_nxt = board;
            incorrect_nxt = incorrect;
            victory_nxt = victory;
            if((board[selection_y][selection_x]&1'b1) == 0) begin
                if((board[selection_y][selection_x]>>1) < 9 ) begin
                    board_nxt[selection_y][selection_x] = board[selection_y][selection_x] + 2;
                end else begin
                    board_nxt[selection_y][selection_x] = 0;
                end
            end else begin
                board_nxt[selection_y][selection_x] = board[selection_y][selection_x];
            end
        end else if(mouse_right && debounce_reg == 0) begin
            debounce_reg_nxt = 20000000;
            board_nxt = board;
            if(board != selected_board_complete) begin
                incorrect_nxt = 1;
                victory_nxt = victory;
            end else begin
                incorrect_nxt = incorrect;
                victory_nxt = 1;
            end
            selection_x_nxt = selection_x;
            selection_y_nxt = selection_y;
        end else if(top && debounce_reg == 0) begin
            debounce_reg_nxt = 20000000;
            board_nxt = board;
            victory_nxt = victory;
            if(selection_y > 0 ) begin
                selection_y_nxt = selection_y - 1;
            end else begin
                selection_y_nxt = 0;
            end
            selection_x_nxt = selection_x;
            incorrect_nxt = incorrect;
        end else if(bottom && debounce_reg == 0) begin
            debounce_reg_nxt = 20000000;
            board_nxt = board;
            victory_nxt = victory;
            if(selection_y < (board_size_squared - 1) ) begin
                selection_y_nxt = selection_y + 1;
            end else begin
                selection_y_nxt = (board_size_squared - 1);
            end
            selection_x_nxt = selection_x;
            incorrect_nxt = incorrect;
        end else if(left && debounce_reg == 0) begin
            debounce_reg_nxt = 20000000;
            board_nxt = board;
            victory_nxt = victory;
            if(selection_x > 0) begin
                selection_x_nxt = selection_x - 1;
            end else begin
                selection_x_nxt = 0;
            end
            selection_y_nxt = selection_y;
            incorrect_nxt = incorrect;
        end else if(right && debounce_reg == 0) begin
            debounce_reg_nxt = 20000000;
            board_nxt = board;
            victory_nxt = victory;
            if(selection_x < (board_size_squared - 1) ) begin
                selection_x_nxt = selection_x + 1;
            end else begin
                selection_x_nxt = (board_size_squared - 1);
            end
            selection_y_nxt = selection_y;
            incorrect_nxt = incorrect;
        end else begin
            board_nxt = board;
            victory_nxt = victory;
            if(debounce_reg>0) begin
                debounce_reg_nxt = debounce_reg - 1;
                incorrect_nxt = incorrect;
            end else begin
                debounce_reg_nxt = debounce_reg;
                incorrect_nxt = 0;
            end
            selection_x_nxt = selection_x;
            selection_y_nxt = selection_y;
        end
    end else begin
        victory_nxt = victory;
        debounce_reg_nxt = 20000000;
        selection_x_nxt = selection_x;
        selection_y_nxt = selection_y;
        board_nxt = selected_board;
        incorrect_nxt = incorrect;
    end
end


endmodule