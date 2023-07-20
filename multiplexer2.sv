module multiplexer(
    input logic s, p, q,
    output logic x
);

    always_comb begin
        if (s) x = p;
        else x = q;
    end
endmodule