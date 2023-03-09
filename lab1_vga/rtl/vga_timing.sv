// File: vga_timing.sv
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_timing (
  output logic [10:0] vcount,
  output logic vsync,
  output logic vblnk,
  output logic [10:0] hcount,
  output logic hsync,
  output logic hblnk,
  input  logic pclk
  );

  parameter   
      VISIBLE_HEIGHT = 600,
      VERTICAL_FRONT_PORCH = 1,
      VERTICAL_SYNC_PULSE = 4,
      FULL_HEIGHT = 628,
      
      VISIBLE_WIDTH = 800,
      HORIZONTAL_FRONT_PORCH = 40,
      HORIZONTAL_SYNC_PULSE = 128,
      FULL_WIDTH = 1056;

  logic[10:0] vcount_nxt = 0;
  logic[10:0] hcount_nxt = 0;

  logic vsync_nxt = 0;
  logic hsync_nxt = 0;

  logic vblnk_nxt = 0;
  logic hblnk_nxt = 0;

  // Describe the actual circuit for the assignment.
  // Video timing controller set for 800x600@60fps
  // using a 40 MHz pixel clock per VESA spec.
  always @(*) begin
    hcount_nxt = (hcount + 1) % FULL_WIDTH;
    if(hcount == FULL_WIDTH - 1) begin
      vcount_nxt = (vcount + 1) % FULL_HEIGHT;
    end else begin
      vcount_nxt = vcount;
    end
  end

  always @(*) begin
		if(hcount_nxt >= VISIBLE_WIDTH && hcount_nxt < FULL_WIDTH) begin
			hblnk_nxt = 1;
		end else begin
			hblnk_nxt = 0;
		end
		
		if(hcount_nxt >= (VISIBLE_WIDTH + HORIZONTAL_FRONT_PORCH) && hcount_nxt < (VISIBLE_WIDTH + HORIZONTAL_FRONT_PORCH + HORIZONTAL_SYNC_PULSE)) begin
			hsync_nxt = 1;
		end else begin
			hsync_nxt = 0;
		end
		
		if((vcount_nxt >= VISIBLE_HEIGHT && vcount_nxt < FULL_HEIGHT)) begin
			vblnk_nxt = 1;
		end else begin
			vblnk_nxt = 0;
		end
		
		if(vcount_nxt >= (VISIBLE_HEIGHT + VERTICAL_FRONT_PORCH) && vcount_nxt < (VISIBLE_HEIGHT + VERTICAL_FRONT_PORCH + VERTICAL_SYNC_PULSE)) begin
			vsync_nxt = 1;
		end else begin
			vsync_nxt = 0;
		end
  end
 
  always @ (posedge pclk) begin
    vcount <= vcount_nxt;
    hcount <= hcount_nxt;

    vsync <= vsync_nxt;
    hsync <= hsync_nxt;

    vblnk <= vblnk_nxt;
    hblnk <= hblnk_nxt;
  end

endmodule
