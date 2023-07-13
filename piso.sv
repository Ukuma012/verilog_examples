module piso_circuit (
    input logic CLK, RST,
    input logic [2:0] D,
    input logic WE,
    output logic Q
);

logic [2:0] data_reg, next_data_reg;

assign Q = data_reg[2];

always_comb begin
    if (WE) begin
        next_data_reg = D;
    end else begin
        next_data_reg = {data_reg[1:0], 1'b0};
    end
end

always_ff @ (posedge CLK) begin
    if (RST) begin
        data_reg <= 3'b000;
    end else begin
        data_reg <= next_data_reg;
    end
end
endmodule