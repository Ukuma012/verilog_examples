module ram #(parameter N = 6, M = 32) (
    input logic clk,
    input logic we,
    input logic [N-1:0] addr,
    input logic [M-1:0] data_in,
    output logic [M-1:0] data_out
);

    logic [M-1:0] mem [2**N-1:0];

    always_ff @(posedge clk) begin
        if (we) mem[addr] <= data_in;
    end

    assign data_out = mem[addr];
endmodule