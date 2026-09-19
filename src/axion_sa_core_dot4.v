`default_nettype none

// Four signed INT8 multipliers feeding one signed 32-bit accumulator.
module axion_sa_core_dot4 (
    input  wire               clk,
    input  wire               rst_n,
    input  wire               ena,
    input  wire               clear_acc,
    input  wire               mac_en,
    input  wire signed [15:0] p0,
    input  wire signed [15:0] p1,
    input  wire signed [15:0] p2,
    input  wire signed [15:0] p3,
    output reg  signed [31:0] acc,
    output wire [7:0]         relu_sat
);

    wire signed [31:0] p0_ext = {{16{p0[15]}}, p0};
    wire signed [31:0] p1_ext = {{16{p1[15]}}, p1};
    wire signed [31:0] p2_ext = {{16{p2[15]}}, p2};
    wire signed [31:0] p3_ext = {{16{p3[15]}}, p3};

    wire signed [31:0] dot_sum = (p0_ext + p1_ext) +
                                 (p2_ext + p3_ext);

    reg signed [31:0] dot_pipe;
    reg               dot_valid;

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
        if (!rst_n) begin
            acc <= 32'sd0;
            dot_pipe  <= 32'sd0;
            dot_valid <= 1'b0;
        end
        else if (ena) begin
            if (clear_acc) begin
                acc <= 32'sd0;
                dot_pipe  <= 32'sd0;
                dot_valid <= 1'b0;
            end else begin
                if (dot_valid)
                    acc <= acc + dot_pipe;

                dot_valid <= mac_en;
                if (mac_en)
                    dot_pipe <= dot_sum;
            end
        end
    end

endmodule

`default_nettype wire
