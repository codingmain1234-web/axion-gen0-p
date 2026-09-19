`default_nettype none

// Four 8-bit SIMD lanes. All lanes execute the same operation in parallel.
module axion_vcore_simd4 (
    input  wire [31:0] a_vec,
    input  wire [31:0] b_vec,
    input  wire [2:0]  op,
    output wire [31:0] y_vec
);

    function [7:0] lane_alu;
        input [7:0] a;
        input [7:0] b;
        input [2:0] lane_op;
        reg [15:0] product;
        begin
            product = a * b;
            case (lane_op)
                3'd0: lane_alu = a + b;
                3'd1: lane_alu = a - b;
                3'd2: lane_alu = product[7:0];
                3'd3: lane_alu = a & b;
                3'd4: lane_alu = a ^ b;
                3'd5: lane_alu = (a > b) ? a : b;
                3'd6: lane_alu = (a < b) ? a : b;
                default: lane_alu = 8'h00;
            endcase
        end
    endfunction

    assign y_vec[7:0]   = lane_alu(a_vec[7:0],   b_vec[7:0],   op);
    assign y_vec[15:8]  = lane_alu(a_vec[15:8],  b_vec[15:8],  op);
    assign y_vec[23:16] = lane_alu(a_vec[23:16], b_vec[23:16], op);
    assign y_vec[31:24] = lane_alu(a_vec[31:24], b_vec[31:24], op);

endmodule

`default_nettype wire
