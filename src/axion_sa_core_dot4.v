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

    // Three-stage MAC pipeline:
    //   1. register the four multiplier outputs
    //   2. reduce the four products into one DOT4 value
    //   3. accumulate the registered DOT4 value
    // This keeps the 16 MHz signoff target viable at the GF180 slow corner while
    // retaining a throughput of one DOT4 operation per clock.
    reg signed [15:0] p0_pipe;
    reg signed [15:0] p1_pipe;
    reg signed [15:0] p2_pipe;
    reg signed [15:0] p3_pipe;
    reg               product_valid;
    reg signed [31:0] dot_pipe;
    reg               dot_valid;

    wire signed [31:0] p0_pipe_ext = {{16{p0_pipe[15]}}, p0_pipe};
    wire signed [31:0] p1_pipe_ext = {{16{p1_pipe[15]}}, p1_pipe};
    wire signed [31:0] p2_pipe_ext = {{16{p2_pipe[15]}}, p2_pipe};
    wire signed [31:0] p3_pipe_ext = {{16{p3_pipe[15]}}, p3_pipe};
    wire signed [31:0] piped_dot_sum = (p0_pipe_ext + p1_pipe_ext) +
                                       (p2_pipe_ext + p3_pipe_ext);

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
            acc           <= 32'sd0;
            product_valid <= 1'b0;
            dot_valid     <= 1'b0;
        end
        else if (ena) begin
            if (clear_acc) begin
                acc           <= 32'sd0;
                product_valid <= 1'b0;
                dot_valid     <= 1'b0;
            end else begin
                if (dot_valid)
                    acc <= acc + dot_pipe;

                dot_valid <= product_valid;
                if (product_valid)
                    dot_pipe <= piped_dot_sum;

                product_valid <= mac_en;
                if (mac_en) begin
                    p0_pipe <= p0;
                    p1_pipe <= p1;
                    p2_pipe <= p2;
                    p3_pipe <= p3;
                end
            end
        end
    end

endmodule

`default_nettype wire
