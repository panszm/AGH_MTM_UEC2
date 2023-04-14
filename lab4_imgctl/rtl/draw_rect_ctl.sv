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
logic signed [47:0] velocity, velocity_nxt;
logic is_dropped, is_dropped_nxt;
logic [27:0] fall_counter, fall_counter_nxt;
logic falling, falling_nxt;

localparam VISIBLE_HEIGHT = 600,
RECT_HEIGHT = 64,
ACCELERATION = 1;

always_ff @(posedge clk) begin
    if(rst) begin
        xpos <= 0;
        ypos <= 0;
        is_dropped <= 0;
        velocity <= 0;
        fall_counter <= 28'hfffffff;
        falling <= 1;
    end else begin
        xpos <= xpos_nxt;
        ypos <= ypos_nxt;
        is_dropped <= is_dropped_nxt;
        velocity <= velocity_nxt;
        fall_counter <= fall_counter_nxt;
        falling <= falling_nxt;
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

    if(is_dropped) begin
        if ((velocity >> 23) < ACCELERATION && ((ypos + ACCELERATION) > (VISIBLE_HEIGHT - RECT_HEIGHT)) && ypos < 2000) begin
            ypos_nxt = VISIBLE_HEIGHT - RECT_HEIGHT;
            velocity_nxt = 0;
            falling_nxt = 1;
            fall_counter_nxt = 28'hfffffff;
        end else if(falling && ((ypos + (velocity >> 23)) > (VISIBLE_HEIGHT - RECT_HEIGHT )) && !fall_counter[19]) begin
            ypos_nxt = VISIBLE_HEIGHT - RECT_HEIGHT;
            velocity_nxt = velocity >> 1;
            falling_nxt = 0;
            fall_counter_nxt = 28'hfffffff;
        end else if(!fall_counter[19]) begin
            if (!falling && velocity < (2*ACCELERATION)) begin
                falling_nxt = 1;
            end else begin
                falling_nxt = falling;
            end
            if(falling) begin 
                ypos_nxt = ypos + (velocity >> 23);
                velocity_nxt = velocity + ACCELERATION;
            end else begin
                ypos_nxt = ypos + ~(velocity >> 23);
                velocity_nxt = velocity - ACCELERATION;
            end
            fall_counter_nxt = 28'hfffffff;
        end else begin
            ypos_nxt = ypos;
            fall_counter_nxt = fall_counter - 1;
            if(falling) begin 
                velocity_nxt = velocity + ACCELERATION;
            end else begin
                velocity_nxt = velocity - ACCELERATION;
            end
            falling_nxt = falling;
        end;
    end else begin
        ypos_nxt = mouse_y_position;
        fall_counter_nxt = fall_counter;
        velocity_nxt = velocity;
        falling_nxt = falling;
    end;
end;

endmodule