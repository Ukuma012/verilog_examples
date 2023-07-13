module sipo_circuit (
    input logic CLK, RST,
    input logic data_in,
    output logic [2:0] Q // parallel data
);

logic [2:0] data_reg, next_data_reg;

assign Q = data_reg;
assign next_data_reg = {data_reg[1:0], data_in};

always_ff @ (posedge CLK) begin
    if (RST) begin
        data_reg <= 3'b000;
    end else begin
        data_reg <= next_data_reg;
    end
end
endmodule