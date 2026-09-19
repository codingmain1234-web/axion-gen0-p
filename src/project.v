/*
 * Copyright (c) 2026 codingmain1234-web
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_codingmain1234_web_axion_gen0p (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    axion_gen0p u_axion_gen0p (
        .clk     (clk),
        .rst_n   (rst_n),
        .ena     (ena),
        .data_in (ui_in),
        .command (uio_in),
        .data_out(uo_out)
    );

    assign uio_out = 8'h00;
    assign uio_oe  = 8'h00;

endmodule

`default_nettype wire
