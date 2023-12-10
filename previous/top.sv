module top();

    logic a, b, c, d;
    assign a = ~b;
    part part(.x(a), .y(b), .z(c));
    assign d = d | c;

endmodule