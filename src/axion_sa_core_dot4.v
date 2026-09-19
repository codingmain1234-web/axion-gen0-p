`default_nettype none

// Four signed INT8 multipliers feeding one signed 32-bit accumulator.
module axion_sa_core_dot4 (
    input  wire               clk,
    input  wire               rst_n,
    input  wire               ena,
    input  wire               clear_acc,
    input  wire               mac_en,
    input  wire [31:0]        a_vec,
    input  wire [31:0]        b_vec,
    output reg  signed [31:0] acc,
    output wire [7:0]         relu_sat
);

    wire signed [7:0] a0 = a_vec[7:0];
    wire signed [7:0] a1 = a_vec[15:8];
    wire signed [7:0] a2 = a_vec[23:16];
    wire signed [7:0] a3 = a_vec[31:24];
    wire signed [7:0] b0 = b_vec[7:0];
    wire signed [7:0] b1 = b_vec[15:8];
    wire signed [7:0] b2 = b_vec[23:16];
    wire signed [7:0] b3 = b_vec[31:24];

    wire signed [15:0] p0 = a0 * b0;
    wire signed [15:0] p1 = a1 * b1;
    wire signed [15:0] p2 = a2 * b2;
    wire signed [15:0] p3 = a3 * b3;

    wire signed [31:0] p0_ext = {{16{p0[15]}}, p0};
    wire signed [31:0] p1_ext = {{16{p1[15]}}, p1};
    wire signed [31:0] p2_ext = {{16{p2[15]}}, p2};
    wire signed [31:0] p3_ext = {{16{p3[15]}}, p3};

    wire signed [31:0] dot_sum = (p0_ext + p1_ext) +
                                 (p2_ext + p3_ext);

    wire signed [31:0] acc_after_mac = acc + dot_sum;

    function [7:0] sat_relu8;
        input signed [31:0] value;
        begin
            if (value < 0)
                sat_relu8 = 8'd0;
            else if (value > 32'sd127)
                sat_relu8 = 8'd127;
            else
                sat_relu8 = value[7:0];
        end
    endfunction

    assign relu_sat = sat_relu8(acc);

    always @(posedge clk) begin
        if (!rst_n)
            acc <= 32'sd0;
        else if (ena) begin
            if (clear_acc)
                acc <= 32'sd0;
            else if (mac_en)
                acc <= acc_after_mac;
        end
    end

endmodule

`default_nettype wire
