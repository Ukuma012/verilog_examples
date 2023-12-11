module shiftreg_sp(
    input logic CLK, RST,
    input logic D,
    output logic[2:0]Q
);

logic[2:0]data_reg, n_data_reg;

assign Q = data_reg;
assign n_data_reg = {data_reg[1:0],D};

always_ff @ (posedge CLK)begin
    if(RST)begin
        data_reg <= 3'b000;
    end else begin
        data_reg <= n_data_reg;
    end
end
endmodule