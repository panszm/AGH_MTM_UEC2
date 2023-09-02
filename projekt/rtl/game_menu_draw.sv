/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Waldemar Świder
 *
 * Description:
 * Drawing game menu objects.
 */
`timescale 1 ns / 1 ps

module game_menu_draw (
    input logic clk,
    input logic rst,

    input logic is_game_on,

    vga_bus     bus_in,
    vga_bus     bus_out
);

/**
 * Local variables and signals
 */
import vga_pkg::*;
			
logic [11:0] rgb_out_nxt;

/**
 * Internal logic
 */
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
    if(!is_game_on) begin
        if(bus_in.vcount == 378 && bus_in.hcount == 461) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 378 && bus_in.hcount == 462) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 378 && bus_in.hcount == 463) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 378 && bus_in.hcount == 464) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 378 && bus_in.hcount == 465) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 379 && bus_in.hcount == 460) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 379 && bus_in.hcount == 461) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 379 && bus_in.hcount == 465) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 379 && bus_in.hcount == 466) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 380 && bus_in.hcount == 460) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 380 && bus_in.hcount == 461) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 380 && bus_in.hcount == 465) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 380 && bus_in.hcount == 466) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 381 && bus_in.hcount == 461) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 381 && bus_in.hcount == 462) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 382 && bus_in.hcount == 461) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 382 && bus_in.hcount == 462) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 383 && bus_in.hcount == 463) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 383 && bus_in.hcount == 464) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 383 && bus_in.hcount == 465) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 384 && bus_in.hcount == 465) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 384 && bus_in.hcount == 466) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 385 && bus_in.hcount == 460) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 385 && bus_in.hcount == 461) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 385 && bus_in.hcount == 465) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 385 && bus_in.hcount == 466) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 386 && bus_in.hcount == 460) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 386 && bus_in.hcount == 461) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 386 && bus_in.hcount == 465) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 386 && bus_in.hcount == 466) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 387 && bus_in.hcount == 461) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 387 && bus_in.hcount == 462) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 387 && bus_in.hcount == 463) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 387 && bus_in.hcount == 464) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 387 && bus_in.hcount == 465) rgb_out_nxt = FONT_COLOR_DIMMED;

        else if(bus_in.vcount >= 378 && bus_in.vcount <= 387 && (bus_in.hcount == 471  || bus_in.hcount == 472)) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 378 && bus_in.hcount == 470) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 378 && bus_in.hcount == 473) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 387 && bus_in.hcount == 470) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 387 && bus_in.hcount == 473) rgb_out_nxt = FONT_COLOR_DIMMED;

        else if(bus_in.vcount == 378 && bus_in.hcount >= 476 && bus_in.hcount <= 483) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 379 && bus_in.hcount == 476) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 379 && bus_in.hcount == 477) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 379 && bus_in.hcount == 482) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 379 && bus_in.hcount == 483) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 380 && bus_in.hcount == 476) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 380 && bus_in.hcount == 481) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 380 && bus_in.hcount == 482) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 381 && bus_in.hcount == 480) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 381 && bus_in.hcount == 481) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 382 && bus_in.hcount == 479) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 382 && bus_in.hcount == 480) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 383 && bus_in.hcount == 478) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 383 && bus_in.hcount == 479) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 384 && bus_in.hcount == 477) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 384 && bus_in.hcount == 478) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 385 && bus_in.hcount == 476) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 385 && bus_in.hcount == 477) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 385 && bus_in.hcount == 483) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 386 && bus_in.hcount == 476) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 386 && bus_in.hcount == 477) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 386 && bus_in.hcount == 482) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 386 && bus_in.hcount == 483) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 387 && bus_in.hcount >= 476 && bus_in.hcount <= 483) rgb_out_nxt = FONT_COLOR_DIMMED;

        else if(bus_in.vcount == 378 && bus_in.hcount >= 485 && bus_in.hcount <= 491) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 379 && (bus_in.hcount == 486 || bus_in.hcount == 487 || bus_in.hcount == 490 || bus_in.hcount == 491) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 380 && (bus_in.hcount == 486 || bus_in.hcount == 487 || bus_in.hcount == 491) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 381 && (bus_in.hcount == 486 || bus_in.hcount == 487 || bus_in.hcount == 489) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 382 && (bus_in.hcount == 486 || bus_in.hcount == 487 || bus_in.hcount == 488 || bus_in.hcount == 489) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 383 && (bus_in.hcount == 486 || bus_in.hcount == 487 || bus_in.hcount == 489) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 384 && (bus_in.hcount == 486 || bus_in.hcount == 487 )) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 385 && (bus_in.hcount == 486 || bus_in.hcount == 487 || bus_in.hcount == 491) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 386 && (bus_in.hcount == 486 || bus_in.hcount == 487 || bus_in.hcount == 490 || bus_in.hcount == 491) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 387 && bus_in.hcount >= 485 && bus_in.hcount <= 491) rgb_out_nxt = FONT_COLOR_DIMMED;

        else if(bus_in.vcount == 380 && (bus_in.hcount == 494 || bus_in.hcount == 495) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 381 && (bus_in.hcount == 494 || bus_in.hcount == 495) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 385 && (bus_in.hcount == 494 || bus_in.hcount == 495) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 386 && (bus_in.hcount == 494 || bus_in.hcount == 495) ) rgb_out_nxt = FONT_COLOR_DIMMED;

        else if(bus_in.vcount == 394 && (bus_in.hcount == 468 || bus_in.hcount == 469 || bus_in.hcount == 470 || bus_in.hcount == 471) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 395 && (bus_in.hcount == 469 || bus_in.hcount == 470) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 396 && (bus_in.hcount == 469 || bus_in.hcount == 470) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 397 && (bus_in.hcount == 469 || bus_in.hcount == 470) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 398 && (bus_in.hcount == 469 || bus_in.hcount == 470) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 399 && (bus_in.hcount == 469 || bus_in.hcount == 470) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 400 && (bus_in.hcount == 469 || bus_in.hcount == 470) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 401 && (bus_in.hcount == 469 || bus_in.hcount == 470 || bus_in.hcount == 474) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 402 && (bus_in.hcount == 469 || bus_in.hcount == 470 || bus_in.hcount == 473 || bus_in.hcount == 474) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 403 && bus_in.hcount >= 468 && bus_in.hcount <= 474) rgb_out_nxt = FONT_COLOR_DIMMED;

        else if(bus_in.vcount == 394 && (bus_in.hcount == 476 || bus_in.hcount == 477 || bus_in.hcount == 482 || bus_in.hcount == 483)) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 395 && (bus_in.hcount == 476 || bus_in.hcount == 477 || bus_in.hcount == 482 || bus_in.hcount == 483)) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 396 && (bus_in.hcount == 476 || bus_in.hcount == 477 || bus_in.hcount == 482 || bus_in.hcount == 483)) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 397 && (bus_in.hcount == 476 || bus_in.hcount == 477 || bus_in.hcount == 482 || bus_in.hcount == 483)) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 398 && (bus_in.hcount == 476 || bus_in.hcount == 477 || bus_in.hcount == 482 || bus_in.hcount == 483)) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 399 && (bus_in.hcount == 476 || bus_in.hcount == 477 || bus_in.hcount == 482 || bus_in.hcount == 483)) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 400 && (bus_in.hcount == 476 || bus_in.hcount == 477 || bus_in.hcount == 482 || bus_in.hcount == 483)) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 401 && (bus_in.hcount == 477 || bus_in.hcount == 478 || bus_in.hcount == 481 || bus_in.hcount == 482)) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 402 && (bus_in.hcount == 478 || bus_in.hcount == 478 || bus_in.hcount == 480 || bus_in.hcount == 481)) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 403 && (bus_in.hcount == 479 || bus_in.hcount == 479)) rgb_out_nxt = FONT_COLOR_DIMMED;

        else if(bus_in.vcount == 394 && (bus_in.hcount == 484 || bus_in.hcount == 485 || bus_in.hcount == 486 || bus_in.hcount == 487) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 395 && (bus_in.hcount == 485 || bus_in.hcount == 486) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 396 && (bus_in.hcount == 485 || bus_in.hcount == 486) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 397 && (bus_in.hcount == 485 || bus_in.hcount == 486) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 398 && (bus_in.hcount == 485 || bus_in.hcount == 486) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 399 && (bus_in.hcount == 485 || bus_in.hcount == 486) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 400 && (bus_in.hcount == 485 || bus_in.hcount == 486) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 401 && (bus_in.hcount == 485 || bus_in.hcount == 486 || bus_in.hcount == 490) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 402 && (bus_in.hcount == 485 || bus_in.hcount == 486 || bus_in.hcount == 489 || bus_in.hcount == 490) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 403 && bus_in.hcount >= 484 && bus_in.hcount <= 490) rgb_out_nxt = FONT_COLOR_DIMMED;

        else if(bus_in.vcount == 396 && (bus_in.hcount == 494 || bus_in.hcount == 495) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 397 && (bus_in.hcount == 494 || bus_in.hcount == 495) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 401 && (bus_in.hcount == 494 || bus_in.hcount == 495) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 402 && (bus_in.hcount == 494 || bus_in.hcount == 495) ) rgb_out_nxt = FONT_COLOR_DIMMED;

        else if(bus_in.vcount == 378 && (bus_in.hcount == 525) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 379 && (bus_in.hcount == 524 || bus_in.hcount == 525 || bus_in.hcount == 526) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 380 && (bus_in.hcount == 523 || bus_in.hcount == 524 || bus_in.hcount == 525 || bus_in.hcount == 526 || bus_in.hcount == 527) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 384 && (bus_in.hcount == 523 || bus_in.hcount == 524 || bus_in.hcount == 525 || bus_in.hcount == 526 || bus_in.hcount == 527) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 385 && (bus_in.hcount == 524 || bus_in.hcount == 525 || bus_in.hcount == 526) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 386 && (bus_in.hcount == 525) ) rgb_out_nxt = FONT_COLOR_DIMMED;

        else if(bus_in.vcount == 397 && (bus_in.hcount == 523 || bus_in.hcount == 527) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 398 && (bus_in.hcount == 522 || bus_in.hcount == 523 || bus_in.hcount == 527 || bus_in.hcount == 528) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 399 && (bus_in.hcount == 521 || bus_in.hcount == 522 || bus_in.hcount == 523 || bus_in.hcount == 527 || bus_in.hcount == 528 || bus_in.hcount == 529) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 400 && (bus_in.hcount == 522 || bus_in.hcount == 523 || bus_in.hcount == 527 || bus_in.hcount == 528) ) rgb_out_nxt = FONT_COLOR_DIMMED;
        else if(bus_in.vcount == 401 && (bus_in.hcount == 523 || bus_in.hcount == 527) ) rgb_out_nxt = FONT_COLOR_DIMMED;


        else rgb_out_nxt = bus_in.rgb;   
    end else begin
        rgb_out_nxt = bus_in.rgb;
    end;
end;

endmodule