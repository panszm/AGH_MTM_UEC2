`timescale 1 ns / 1 ps

module game_menu (
    input  logic clk,
    input  logic rst,
    input  logic top,
    input  logic bottom,
    input  logic right,
    input  logic left,
    input  logic mouse_left,
    output logic[2:0] board_size,
    output logic[2:0] lvl,
    output logic is_game_on
);

/**
 * Local variables and signals
 */
logic[2:0] board_size_nxt;
logic[2:0] lvl_next;
logic is_game_on_nxt;
logic[26:0] debounce_reg = 0;
logic[26:0] debounce_reg_nxt = 0;

always_ff @(posedge clk) begin
    if(rst) begin
        board_size <= 2;
        is_game_on <= 0;
        debounce_reg <= 0;
        lvl <= 1;
    end else begin
        board_size <= board_size_nxt;
        is_game_on <= is_game_on_nxt;
        debounce_reg <= debounce_reg_nxt;
        lvl <= lvl_next;
    end
end

always_comb begin
    if(!is_game_on) begin
        if(mouse_left) begin
            lvl_next = lvl;
            is_game_on_nxt = 1;
            board_size_nxt = board_size;
            if(debounce_reg>0) begin
                debounce_reg_nxt = debounce_reg - 1;
            end else begin
                debounce_reg_nxt = debounce_reg;
            end
        end else if(bottom) begin
            lvl_next = lvl;
            is_game_on_nxt = is_game_on;
            if(debounce_reg == 0)begin
                debounce_reg_nxt = 20000000;
                if(board_size >= 3) begin
                    board_size_nxt = board_size - 1;
                end else begin
                    board_size_nxt = board_size;
                end
            end else begin
                board_size_nxt = board_size;
                if(debounce_reg>0) begin
                    debounce_reg_nxt = debounce_reg - 1;
                end else begin
                    debounce_reg_nxt = debounce_reg;
                end
            end
        end else if(top) begin
            lvl_next = lvl;
            is_game_on_nxt = is_game_on;
            if(debounce_reg == 0)begin
                debounce_reg_nxt = 20000000;
                if(board_size <=3 ) begin
                    board_size_nxt = board_size + 1;
                end else begin
                    board_size_nxt = board_size;
                end
            end else begin
                board_size_nxt = board_size;
                if(debounce_reg>0) begin
                    debounce_reg_nxt = debounce_reg - 1;
                end else begin
                    debounce_reg_nxt = debounce_reg;
                end
            end
        end else if(right) begin
            is_game_on_nxt = is_game_on;
            board_size_nxt = board_size;
            if(debounce_reg == 0)begin
                debounce_reg_nxt = 20000000;
                if(lvl <=2 ) begin
                    lvl_next = lvl + 1;
                end else begin
                    lvl_next = lvl;
                end
            end else begin
                lvl_next = lvl;
                if(debounce_reg>0) begin
                    debounce_reg_nxt = debounce_reg - 1;
                end else begin
                    debounce_reg_nxt = debounce_reg;
                end
            end
        end else if(left) begin
            is_game_on_nxt = is_game_on;
            board_size_nxt = board_size;
            if(debounce_reg == 0) begin
                debounce_reg_nxt = 20000000;
                if(lvl >= 2 ) begin
                    lvl_next = lvl - 1;
                end else begin
                    lvl_next = lvl;
                end
            end else begin
                lvl_next = lvl;
                if(debounce_reg>0) begin
                    debounce_reg_nxt = debounce_reg - 1;
                end else begin
                    debounce_reg_nxt = debounce_reg;
                end
            end
        end else begin
            if(debounce_reg>0) begin
                debounce_reg_nxt = debounce_reg - 1;
            end else begin
                debounce_reg_nxt = debounce_reg;
            end
            lvl_next = lvl;
            is_game_on_nxt = is_game_on;
            board_size_nxt = board_size;
        end
    end else begin
        lvl_next = lvl;
        is_game_on_nxt = is_game_on;
        board_size_nxt = board_size;
        debounce_reg_nxt = debounce_reg;
    end
end


endmodule