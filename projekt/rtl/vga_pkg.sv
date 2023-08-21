/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Package with vga related constants.
 */

package vga_pkg;

localparam   
      VISIBLE_HEIGHT = 768,
      VERTICAL_FRONT_PORCH = 3,
      VERTICAL_SYNC_PULSE = 6,
      FULL_HEIGHT = 806,
      
      VISIBLE_WIDTH = 1024,
      HORIZONTAL_FRONT_PORCH = 24,
      HORIZONTAL_SYNC_PULSE = 136,
      FULL_WIDTH = 1344;

// Add VGA timing parameters here and refer to them in other modules.

endpackage
