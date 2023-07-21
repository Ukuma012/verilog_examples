module dff_loop(
    input logic C
);

logic D, Q;

always_ff @(posedge C) begin
    Q <= D
end

always_comb begin
    D = ~Q;
end
endmodule