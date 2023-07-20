module comb_example(
    input logic a, b, c,
    output logic x, y
);

    logic g, h;
    assign g = a & b;
    assign h = ~c;

    logic p, q;
    assign x = g | h;
    assign p = h & 1'b1;
    assign q = ~(1'b1);

    assign y = p | q;
endmodule


