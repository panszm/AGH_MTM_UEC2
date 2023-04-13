`timescale 1 ns / 1 ps

module draw_rect_ctl (
input logic rst,
input logic clk,
input logic mouse_left,
input logic [11:0] mouse_x_position,
input logic [11:0] mouse_y_position,

output logic [11:0] xpos,
output logic [11:0] ypos
);

logic [11:0] xpos_nxt, ypos_nxt;
int velocity, velocity_nxt;
logic is_dropped, is_dropped_nxt;
logic [27:0] fall_counter, fall_counter_nxt;

localparam VISIBLE_HEIGHT = 600,
RECT_HEIGHT = 64,
ACCELERATION = 16;

always_ff @(posedge clk) begin
    if(rst) begin
        xpos <= 0;
        ypos <= 0;
        is_dropped <= 0;
        velocity <= 0;
        fall_counter <= 28'hfffffff;
    end else begin
        xpos <= xpos_nxt;
        ypos <= ypos_nxt;
        is_dropped <= is_dropped_nxt;
        velocity <= velocity_nxt;
        fall_counter <= fall_counter_nxt;
    end
end

always_comb begin
    if(mouse_left) begin
        is_dropped_nxt = 1;
    end else begin
        is_dropped_nxt = is_dropped;
    end;

    if(is_dropped) begin
        xpos_nxt = xpos;
    end else begin
        xpos_nxt = mouse_x_position;
    end;

    if(is_dropped && velocity != 0) begin
        if(ypos + (velocity / (1 << 27)) > VISIBLE_HEIGHT - RECT_HEIGHT ) begin
            ypos_nxt = VISIBLE_HEIGHT - RECT_HEIGHT;
            velocity_nxt = -1 * (velocity / 2);
            fall_counter_nxt = 28'hfffffff;
        end else if(!fall_counter[21]) begin
            ypos_nxt = ypos + (velocity  / (1 << 27));
            fall_counter_nxt = 28'hfffffff;
            velocity_nxt = velocity + ACCELERATION;
        end else begin
            ypos_nxt = ypos;
            fall_counter_nxt = fall_counter - 1;
            velocity_nxt = velocity + ACCELERATION;
        end;
    end else if (is_dropped) begin
        ypos_nxt = ypos;
        fall_counter_nxt = fall_counter - 1;
        velocity_nxt = velocity + ACCELERATION;
    end else begin
        ypos_nxt = mouse_y_position;
        fall_counter_nxt = fall_counter;
        velocity_nxt = velocity + ACCELERATION;
    end;
end;

endmodule