/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Waldemar Świder
 *
 * Description:
 * Logic for gameboard, and in-game ui control of the gameboard.
 */
`timescale 1 ns / 1 ps

module game_board_ctl (
    //global signals
    input  logic        clk,
    input  logic        rst,
    //ui signals
    input  logic        top,
    input  logic        bottom,
    input  logic        left,
    input  logic        right,
    input  logic        mouse_left,
    input  logic        mouse_right,
    //game related signals
    input  logic        is_game_on,
    input  logic[2:0]   board_size,
    input  logic [5:0]  selected_board [15:0][15:0],
    input  logic [5:0]  selected_board_complete [15:0][15:0],
    //outputs
    output logic [5:0]  board [15:0][15:0],
    output logic[3:0]   selection_x,
    output logic[3:0]   selection_y,
    output logic        incorrect,
    output logic        victory,
    output logic        victory_rst
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
logic victory_rst_nxt = 0;

assign board_size_squared = board_size * board_size;

/**
 * Internal logic
 */
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
        victory_rst <= 0;
    end else begin
        board <= board_nxt;
        debounce_reg <= debounce_reg_nxt;
        selection_x <= selection_x_nxt;
        selection_y <= selection_y_nxt;
        incorrect <= incorrect_nxt;
        victory <= victory_nxt;
        victory_rst <= victory_rst_nxt;
    end
end

always_comb begin
    if(is_game_on && !victory) begin
        victory_rst_nxt = victory_rst;
        if(mouse_left && debounce_reg == 0) begin
            board_nxt = board;
            debounce_reg_nxt = 20000000;
            selection_x_nxt = selection_x;
            selection_y_nxt = selection_y;
            incorrect_nxt = incorrect;
            victory_nxt = victory;
            if((board[selection_y][selection_x]&1'b1) == 0) begin
                if((board[selection_y][selection_x]>>1) < (board_size * board_size) ) begin
                    board_nxt[selection_y][selection_x] = board[selection_y][selection_x] + 2;
                end else begin
                    board_nxt[selection_y][selection_x] = 0;
                end
            end else begin
                board_nxt[selection_y][selection_x] = board[selection_y][selection_x];
            end
        end else if(mouse_right && debounce_reg == 0) begin
            board_nxt = board;
            selection_x_nxt = selection_x;
            selection_y_nxt = selection_y;
            if(board == selected_board_complete) begin
                debounce_reg_nxt = 80000000;
                incorrect_nxt = incorrect;
                victory_nxt = 1;
            end else begin
                debounce_reg_nxt = 20000000;
                incorrect_nxt = 1;
                victory_nxt = victory;
            end
        end else if(top && debounce_reg == 0) begin
            board_nxt = board;
            debounce_reg_nxt = 20000000;
            selection_x_nxt = selection_x;
            incorrect_nxt = incorrect;
            victory_nxt = victory;
            if(selection_y > 0 ) begin
                selection_y_nxt = selection_y - 1;
            end else begin
                selection_y_nxt = 0;
            end
        end else if(bottom && debounce_reg == 0) begin
            board_nxt = board;
            debounce_reg_nxt = 20000000;
            selection_x_nxt = selection_x;
            incorrect_nxt = incorrect;
            victory_nxt = victory;
            if(selection_y < (board_size_squared - 1) ) begin
                selection_y_nxt = selection_y + 1;
            end else begin
                selection_y_nxt = (board_size_squared - 1);
            end
        end else if(left && debounce_reg == 0) begin
            board_nxt = board;
            debounce_reg_nxt = 20000000;
            selection_y_nxt = selection_y;
            incorrect_nxt = incorrect;
            victory_nxt = victory;
            if(selection_x > 0) begin
                selection_x_nxt = selection_x - 1;
            end else begin
                selection_x_nxt = 0;
            end
        end else if(right && debounce_reg == 0) begin
            board_nxt = board;
            debounce_reg_nxt = 20000000;
            selection_y_nxt = selection_y;
            incorrect_nxt = incorrect;
            victory_nxt = victory;
            if(selection_x < (board_size_squared - 1) ) begin
                selection_x_nxt = selection_x + 1;
            end else begin
                selection_x_nxt = (board_size_squared - 1);
            end
        end else begin
            board_nxt = board;
            selection_x_nxt = selection_x;
            selection_y_nxt = selection_y;
            victory_nxt = victory;
            if(debounce_reg>0) begin
                debounce_reg_nxt = debounce_reg - 1;
                incorrect_nxt = incorrect;
            end else begin
                debounce_reg_nxt = debounce_reg;
                incorrect_nxt = 0;
            end
        end
    end else begin
        selection_x_nxt = selection_x;
        selection_y_nxt = selection_y;
        victory_nxt = victory;
        if(!is_game_on) begin
            debounce_reg_nxt = 20000000;
            victory_rst_nxt = victory_rst;
        end else begin
            if(debounce_reg>0) begin
                debounce_reg_nxt = debounce_reg - 1;
                victory_rst_nxt = victory_rst;
            end else begin
                debounce_reg_nxt = debounce_reg;
                victory_rst_nxt = 1;
            end
        end
        if (victory) begin 
            board_nxt = board;
            incorrect_nxt = 0;
        end else begin
            board_nxt = selected_board;
            incorrect_nxt = incorrect;
        end
    end
end


endmodule