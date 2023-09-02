/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 * Updated by: Waldemar Świder
 *
 * Description:
 * ROM of number characters.
 */
`timescale 1ns / 1ps
// ROM with synchonous read (inferring Block RAM)
// character ROM
module font_rom_numerical
    (
        input  logic        clk,
        input  logic[10:0]  addr,            // {char_code[6:0], char_line[3:0]}
        output logic[15:0]  char_line_pixels // pixels of the character line
    );

    // signal declaration
    logic [15:0] data;

    // body
    always_ff @(posedge clk)
        char_line_pixels <= data;

    always_comb begin
        case (addr)
            //code x00
            11'h000: data = 15'b0000000000000000; //
            11'h001: data = 15'b0000000000000000; //
            11'h002: data = 15'b0000000000000000; //
            11'h003: data = 15'b0000000000000000; //
            11'h004: data = 15'b0000000000000000; //
            11'h005: data = 15'b0000000000000000; //
            11'h006: data = 15'b0000000000000000; //
            11'h007: data = 15'b0000000000000000; //
            11'h008: data = 15'b0000000000000000; //
            11'h009: data = 15'b0000000000000000; //
            11'h00a: data = 15'b0000000000000000; //
            11'h00b: data = 15'b0000000000000000; //
            11'h00c: data = 15'b0000000000000000; //
            11'h00d: data = 15'b0000000000000000; //
            11'h00e: data = 15'b0000000000000000; //
            11'h00f: data = 15'b0000000000000000; //
            //code x01
            11'h010: data = 15'b0000000000000000; //
            11'h011: data = 15'b0000000000000000; //
            11'h012: data = 15'b0000011111000000; //  *****
            11'h013: data = 15'b0000110001100000; // **   **
            11'h014: data = 15'b0000110001100000; // **   **
            11'h015: data = 15'b0000110011100000; // **  ***
            11'h016: data = 15'b0000110111100000; // ** ****
            11'h017: data = 15'b0000111101100000; // **** **
            11'h018: data = 15'b0000111001100000; // ***  **
            11'h019: data = 15'b0000110001100000; // **   **
            11'h01a: data = 15'b0000110001100000; // **   **
            11'h01b: data = 15'b0000011111000000; //  *****
            11'h01c: data = 15'b0000000000000000; //
            11'h01d: data = 15'b0000000000000000; //
            11'h01e: data = 15'b0000000000000000; //
            11'h01f: data = 15'b0000000000000000; //
            //code x31
            11'h020: data = 15'b0000000000000000; //
            11'h021: data = 15'b0000000000000000; //
            11'h022: data = 15'b0000000110000000; //
            11'h023: data = 15'b0000001110000000; //
            11'h024: data = 15'b0000011110000000; //    **
            11'h025: data = 15'b0000000110000000; //   ***
            11'h026: data = 15'b0000000110000000; //  ****
            11'h027: data = 15'b0000000110000000; //    **
            11'h028: data = 15'b0000000110000000; //    **
            11'h029: data = 15'b0000000110000000; //    **
            11'h02a: data = 15'b0000000110000000; //    **
            11'h02b: data = 15'b0000011111100000; //    **
            11'h02c: data = 15'b0000000000000000; //    **
            11'h02d: data = 15'b0000000000000000; //  ******
            11'h02e: data = 15'b0000000000000000; //
            11'h02f: data = 15'b0000000000000000; //
            //code x32
            11'h030: data = 15'b0000000000000000; //
            11'h031: data = 15'b0000000000000000; //
            11'h032: data = 15'b0000011111000000; //  *****
            11'h033: data = 15'b0000110001100000; // **   **
            11'h034: data = 15'b0000000001100000; //      **
            11'h035: data = 15'b0000000011000000; //     **
            11'h036: data = 15'b0000000110000000; //    **
            11'h037: data = 15'b0000001100000000; //   **
            11'h038: data = 15'b0000011000000000; //  **
            11'h039: data = 15'b0000110000000000; // **
            11'h03a: data = 15'b0000110001100000; // **   **
            11'h03b: data = 15'b0000111111100000; // *******
            11'h03c: data = 15'b0000000000000000; //
            11'h03d: data = 15'b0000000000000000; //
            11'h03e: data = 15'b0000000000000000; //
            11'h03f: data = 15'b0000000000000000; //
            //code x33
            11'h040: data = 15'b0000000000000000; //
            11'h041: data = 15'b0000000000000000; //
            11'h042: data = 15'b0000011111000000; //  *****
            11'h043: data = 15'b0000110001100000; // **   **
            11'h044: data = 15'b0000000001100000; //      **
            11'h045: data = 15'b0000000001100000; //      **
            11'h046: data = 15'b0000001111000000; //   ****
            11'h047: data = 15'b0000000001100000; //      **
            11'h048: data = 15'b0000000001100000; //      **
            11'h049: data = 15'b0000000001100000; //      **
            11'h04a: data = 15'b0000110001100000; // **   **
            11'h04b: data = 15'b0000011111000000; //  *****
            11'h04c: data = 15'b0000000000000000; //
            11'h04d: data = 15'b0000000000000000; //
            11'h04e: data = 15'b0000000000000000; //
            11'h04f: data = 15'b0000000000000000; //
            //code x34
            11'h050: data = 15'b0000000000000000; //
            11'h051: data = 15'b0000000000000000; //
            11'h052: data = 15'b0000000011000000; //     **
            11'h053: data = 15'b0000000111000000; //    ***
            11'h054: data = 15'b0000001111000000; //   ****
            11'h055: data = 15'b0000011011000000; //  ** **
            11'h056: data = 15'b0000110011000000; // **  **
            11'h057: data = 15'b0000111111100000; // *******
            11'h058: data = 15'b0000000011000000; //     **
            11'h059: data = 15'b0000000011000000; //     **
            11'h05a: data = 15'b0000000011000000; //     **
            11'h05b: data = 15'b0000000111100000; //    ****
            11'h05c: data = 15'b0000000000000000; //
            11'h05d: data = 15'b0000000000000000; //
            11'h05e: data = 15'b0000000000000000; //
            11'h05f: data = 15'b0000000000000000; //
            //code x35
            11'h060: data = 15'b0000000000000000; //
            11'h061: data = 15'b0000000000000000; //
            11'h062: data = 15'b0000111111100000; // *******
            11'h063: data = 15'b0000110000000000; // **
            11'h064: data = 15'b0000110000000000; // **
            11'h065: data = 15'b0000110000000000; // **
            11'h066: data = 15'b0000111111000000; // ******
            11'h067: data = 15'b0000000001100000; //      **
            11'h068: data = 15'b0000000001100000; //      **
            11'h069: data = 15'b0000000001100000; //      **
            11'h06a: data = 15'b0000110001100000; // **   **
            11'h06b: data = 15'b0000011111000000; //  *****
            11'h06c: data = 15'b0000000000000000; //
            11'h06d: data = 15'b0000000000000000; //
            11'h06e: data = 15'b0000000000000000; //
            11'h06f: data = 15'b0000000000000000; //
            //code x36
            11'h070: data = 15'b0000000000000000; //
            11'h071: data = 15'b0000000000000000; //
            11'h072: data = 15'b0000001110000000; //   ***
            11'h073: data = 15'b0000011000000000; //  **
            11'h074: data = 15'b0000110000000000; // **
            11'h075: data = 15'b0000110000000000; // **
            11'h076: data = 15'b0000111111000000; // ******
            11'h077: data = 15'b0000110001100000; // **   **
            11'h078: data = 15'b0000110001100000; // **   **
            11'h079: data = 15'b0000110001100000; // **   **
            11'h07a: data = 15'b0000110001100000; // **   **
            11'h07b: data = 15'b0000011111000000; //  *****
            11'h07c: data = 15'b0000000000000000; //
            11'h07d: data = 15'b0000000000000000; //
            11'h07e: data = 15'b0000000000000000; //
            11'h07f: data = 15'b0000000000000000; //
            //code x37
            11'h080: data = 15'b0000000000000000; //
            11'h081: data = 15'b0000000000000000; //
            11'h082: data = 15'b0000111111100000; // *******
            11'h083: data = 15'b0000110001100000; // **   **
            11'h084: data = 15'b0000000001100000; //      **
            11'h085: data = 15'b0000000001100000; //      **
            11'h086: data = 15'b0000000011000000; //     **
            11'h087: data = 15'b0000000110000000; //    **
            11'h088: data = 15'b0000001100000000; //   **
            11'h089: data = 15'b0000001100000000; //   **
            11'h08a: data = 15'b0000001100000000; //   **
            11'h08b: data = 15'b0000001100000000; //   **
            11'h08c: data = 15'b0000000000000000; //
            11'h08d: data = 15'b0000000000000000; //
            11'h08e: data = 15'b0000000000000000; //
            11'h08f: data = 15'b0000000000000000; //
            //code x38
            11'h090: data = 15'b0000000000000000; //
            11'h091: data = 15'b0000000000000000; //
            11'h092: data = 15'b0000011111000000; //  *****
            11'h093: data = 15'b0000110001100000; // **   **
            11'h094: data = 15'b0000110001100000; // **   **
            11'h095: data = 15'b0000110001100000; // **   **
            11'h096: data = 15'b0000011111000000; //  *****
            11'h097: data = 15'b0000110001100000; // **   **
            11'h098: data = 15'b0000110001100000; // **   **
            11'h099: data = 15'b0000110001100000; // **   **
            11'h09a: data = 15'b0000110001100000; // **   **
            11'h09b: data = 15'b0000011111000000; //  *****
            11'h09c: data = 15'b0000000000000000; //
            11'h09d: data = 15'b0000000000000000; //
            11'h09e: data = 15'b0000000000000000; //
            11'h09f: data = 15'b0000000000000000; //
            //code x39
            11'h0a0: data = 15'b0000000000000000; //
            11'h0a1: data = 15'b0000000000000000; //
            11'h0a2: data = 15'b0000011111000000; //  *****
            11'h0a3: data = 15'b0000110001100000; // **   **
            11'h0a4: data = 15'b0000110001100000; // **   **
            11'h0a5: data = 15'b0000110001100000; // **   **
            11'h0a6: data = 15'b0000011111100000; //  ******
            11'h0a7: data = 15'b0000000001100000; //      **
            11'h0a8: data = 15'b0000000001100000; //      **
            11'h0a9: data = 15'b0000000001100000; //      **
            11'h0aa: data = 15'b0000000011000000; //     **
            11'h0ab: data = 15'b0000011110000000; //  ****
            11'h0ac: data = 15'b0000000000000000; //
            11'h0ad: data = 15'b0000000000000000; //
            11'h0ae: data = 15'b0000000000000000; //
            11'h0af: data = 15'b0000000000000000; //
            //code x41
            11'h0b0: data = 15'b0000000000000000; //
            11'h0b1: data = 15'b0000000000000000; //
            11'h0b2: data = 15'b0000000100000000; //    *
            11'h0b3: data = 15'b0000001110000000; //   ***
            11'h0b4: data = 15'b0000011011000000; //  ** **
            11'h0b5: data = 15'b0000110001100000; // **   **
            11'h0b6: data = 15'b0000110001100000; // **   **
            11'h0b7: data = 15'b0000111111100000; // *******
            11'h0b8: data = 15'b0000110001100000; // **   **
            11'h0b9: data = 15'b0000110001100000; // **   **
            11'h0ba: data = 15'b0000110001100000; // **   **
            11'h0bb: data = 15'b0000110001100000; // **   **
            11'h0bc: data = 15'b0000000000000000; //
            11'h0bd: data = 15'b0000000000000000; //
            11'h0be: data = 15'b0000000000000000; //
            11'h0bf: data = 15'b0000000000000000; //
            //code x42
            11'h0c0: data = 15'b0000000000000000; //
            11'h0c1: data = 15'b0000000000000000; //
            11'h0c2: data = 15'b0000111111000000; // ******
            11'h0c3: data = 15'b0000011001100000; //  **  **
            11'h0c4: data = 15'b0000011001100000; //  **  **
            11'h0c5: data = 15'b0000011001100000; //  **  **
            11'h0c6: data = 15'b0000011111000000; //  *****
            11'h0c7: data = 15'b0000011001100000; //  **  **
            11'h0c8: data = 15'b0000011001100000; //  **  **
            11'h0c9: data = 15'b0000011001100000; //  **  **
            11'h0ca: data = 15'b0000011001100000; //  **  **
            11'h0cb: data = 15'b0000111111000000; // ******
            11'h0cc: data = 15'b0000000000000000; //
            11'h0cd: data = 15'b0000000000000000; //
            11'h0ce: data = 15'b0000000000000000; //
            11'h0cf: data = 15'b0000000000000000; //
            //code x43
            11'h0d0: data = 15'b0000000000000000; //
            11'h0d1: data = 15'b0000000000000000; //
            11'h0d2: data = 15'b0000001111000000; //   ****
            11'h0d3: data = 15'b0000011001100000; //  **  **
            11'h0d4: data = 15'b0000110000100000; // **    *
            11'h0d5: data = 15'b0000110000000000; // **
            11'h0d6: data = 15'b0000110000000000; // **
            11'h0d7: data = 15'b0000110000000000; // **
            11'h0d8: data = 15'b0000110000000000; // **
            11'h0d9: data = 15'b0000110000100000; // **    *
            11'h0da: data = 15'b0000011001100000; //  **  **
            11'h0db: data = 15'b0000001111000000; //   ****
            11'h0dc: data = 15'b0000000000000000; //
            11'h0dd: data = 15'b0000000000000000; //
            11'h0de: data = 15'b0000000000000000; //
            11'h0df: data = 15'b0000000000000000; //
            //code x44
            11'h0e0: data = 15'b0000000000000000; //
            11'h0e1: data = 15'b0000000000000000; //
            11'h0e2: data = 15'b0000111110000000; // *****
            11'h0e3: data = 15'b0000011011000000; //  ** **
            11'h0e4: data = 15'b0000011001100000; //  **  **
            11'h0e5: data = 15'b0000011001100000; //  **  **
            11'h0e6: data = 15'b0000011001100000; //  **  **
            11'h0e7: data = 15'b0000011001100000; //  **  **
            11'h0e8: data = 15'b0000011001100000; //  **  **
            11'h0e9: data = 15'b0000011001100000; //  **  **
            11'h0ea: data = 15'b0000011011000000; //  ** **
            11'h0eb: data = 15'b0000111110000000; // *****
            11'h0ec: data = 15'b0000000000000000; //
            11'h0ed: data = 15'b0000000000000000; //
            11'h0ee: data = 15'b0000000000000000; //
            11'h0ef: data = 15'b0000000000000000; //
            //code x45
            11'h0f0: data = 15'b0000000000000000; //
            11'h0f1: data = 15'b0000000000000000; //
            11'h0f2: data = 15'b0000111111100000; // *******
            11'h0f3: data = 15'b0000011001100000; //  **  **
            11'h0f4: data = 15'b0000011000100000; //  **   *
            11'h0f5: data = 15'b0000011010000000; //  ** *
            11'h0f6: data = 15'b0000011110000000; //  ****
            11'h0f7: data = 15'b0000011010000000; //  ** *
            11'h0f8: data = 15'b0000011000000000; //  **
            11'h0f9: data = 15'b0000011000100000; //  **   *
            11'h0fa: data = 15'b0000011001100000; //  **  **
            11'h0fb: data = 15'b0000111111100000; // *******
            11'h0fc: data = 15'b0000000000000000; //
            11'h0fd: data = 15'b0000000000000000; //
            11'h0fe: data = 15'b0000000000000000; //
            11'h0ff: data = 15'b0000000000000000; //
            //code x46
            11'h100: data = 15'b0000000000000000; //
            11'h101: data = 15'b0000000000000000; //
            11'h102: data = 15'b0000111111100000; // *******
            11'h103: data = 15'b0000011001100000; //  **  **
            11'h104: data = 15'b0000011000100000; //  **   *
            11'h105: data = 15'b0000011010000000; //  ** *
            11'h106: data = 15'b0000011110000000; //  ****
            11'h107: data = 15'b0000011010000000; //  ** *
            11'h108: data = 15'b0000011000000000; //  **
            11'h109: data = 15'b0000011000000000; //  **
            11'h10a: data = 15'b0000011000000000; //  **
            11'h10b: data = 15'b0000111100000000; // ****
            11'h10c: data = 15'b0000000000000000; //
            11'h10d: data = 15'b0000000000000000; //
            11'h10e: data = 15'b0000000000000000; //
            11'h10f: data = 15'b0000000000000000; //
            //code x47
            11'h110: data = 15'b0000000000000000; //
            11'h111: data = 15'b0000000000000000; //
            11'h112: data = 15'b0000001111000000; //   ****
            11'h113: data = 15'b0000011001100000; //  **  **
            11'h114: data = 15'b0000110000100000; // **    *
            11'h115: data = 15'b0000110000000000; // **
            11'h116: data = 15'b0000110000000000; // **
            11'h117: data = 15'b0000110111100000; // ** ****
            11'h118: data = 15'b0000110001100000; // **   **
            11'h119: data = 15'b0000110001100000; // **   **
            11'h11a: data = 15'b0000011001100000; //  **  **
            11'h11b: data = 15'b0000001110100000; //   *** *
            11'h11c: data = 15'b0000000000000000; //
            11'h11d: data = 15'b0000000000000000; //
            11'h11e: data = 15'b0000000000000000; //
            11'h11f: data = 15'b0000000000000000; //
            default: data = 15'b0000000000000000;
        endcase
        end

endmodule
