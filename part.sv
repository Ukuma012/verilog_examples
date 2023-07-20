module part(
    input logic x,
    output logic y,
    output logic z
);

    logic g;
    assign y = ~x;
    assign g = x & y;
    assign z = ~g;
endmodule