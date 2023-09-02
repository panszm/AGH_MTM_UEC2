/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 * Updated by: Waldemar Świder
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
      FULL_WIDTH = 1344,
      
      SINGLE_RECT_CHAR_WIDTH = 16,
      SINGLE_RECT_CHAR_HEIGHT = 16,

      FONT_COLOR = 12'hf_f_f,
      FONT_COLOR_DIMMED = 12'h6_6_6,
      FONT_SELECTION_COLOR = 12'h3_3_f,
      FONT_LIGHT_SELECTION_COLOR = 12'ha_a_f,
      FONT_SELECTION_COLOR_LOCKED = 12'hf_3_3,
      FONT_LIGHT_SELECTION_COLOR_LOCKED = 12'hf_a_a,

      LINES_COLOR = 12'h7_7_7,
      LINES_COLOR_INCORRECT = 12'hf_7_7,
      LINES_COLOR_VICTORY = 12'h7_f_7;

// Add VGA timing parameters here and refer to them in other modules.

endpackage
