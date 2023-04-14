/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 * Waldemar Świder
 *
 * Description:
 * Testbench for draw_rect_ctl.
 */

`timescale 1 ns / 1 ps

module draw_rect_ctl_tb;


/**
 *  Local parameters
 */

localparam CLK_PERIOD = 25;     // 40 MHz


/**
 * Local variables and signals
 */

logic clk, rst;
logic mouse_left;
logic [11:0] mouse_x_position, mouse_y_position, rect_x_position, rect_y_position;

assign mouse_x_position = 50;
assign mouse_y_position = 0;

/**
 * Clock generation
 */

initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end


/**
 * Submodules instances
 */
draw_rect_ctl u_draw_rect_ctl (
    .clk,
    .rst,
    .mouse_left(mouse_left),
    .mouse_x_position(mouse_x_position),
    .mouse_y_position(mouse_y_position),
    .xpos(rect_x_position),
    .ypos(rect_y_position)
);

/**
 * Main test
 */

initial begin
    rst = 1'b0;
    # 1000 rst = 1'b1;
    # 2000 rst = 1'b0;

    # 1000 mouse_left = 1'b1;
    # 1000 mouse_left = 1'b0;

    $display("If simulation ends before the testbench");

    # 1000000
    // End the simulation.
    $display("Simulation is over, check the waveforms.");
    $finish;
end

endmodule
