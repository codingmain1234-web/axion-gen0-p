`default_nettype none

// Four physical signed INT8 multipliers shared by the V-Core and SA-Core.
// The low eight product bits are identical for signed and unsigned operands,
// so the V-Core's MUL-low operation can reuse the SA-Core products.
module axion_mul4_shared (
    input  wire [31:0]        a_vec,
    input  wire [31:0]        b_vec,
    output wire signed [15:0] p0,
    output wire signed [15:0] p1,
    output wire signed [15:0] p2,
    output wire signed [15:0] p3,
    output wire [31:0]        mul_low_vec
);

    assign p0 = $signed(a_vec[7:0])   * $signed(b_vec[7:0]);
    assign p1 = $signed(a_vec[15:8])  * $signed(b_vec[15:8]);
    assign p2 = $signed(a_vec[23:16]) * $signed(b_vec[23:16]);
    assign p3 = $signed(a_vec[31:24]) * $signed(b_vec[31:24]);

    assign mul_low_vec = {p3[7:0], p2[7:0], p1[7:0], p0[7:0]};

endmodule

`default_nettype wire
