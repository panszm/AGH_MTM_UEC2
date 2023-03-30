/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Package with vga related constants.
 */

package vga_pkg;

// Parameters for VGA Display 800 x 600 @ 60fps using a 40 MHz clock;
localparam   
      VISIBLE_HEIGHT = 600,
      VERTICAL_FRONT_PORCH = 1,
      VERTICAL_SYNC_PULSE = 4,
      FULL_HEIGHT = 628,
      
      VISIBLE_WIDTH = 800,
      HORIZONTAL_FRONT_PORCH = 40,
      HORIZONTAL_SYNC_PULSE = 128,
      FULL_WIDTH = 1056;

// Add VGA timing parameters here and refer to them in other modules.

endpackage
