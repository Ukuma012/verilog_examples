module multiplexer(
    input logic s, p, q,
    output logic x
);

    assign x = s ? p : q;

endmodule