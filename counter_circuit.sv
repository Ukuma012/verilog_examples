module couter_circuit {
    input logic CLK, RST,
    output logic [3:0] COUNT
};

logic [3:0] n_count;

always_comb begin
    if(COUNT == 4'd9) begin
        n_count = 4'd0;
    end else begin
        n_count = COUNT + 1'b1;
    end
end

always_ff @ (posedge CLK) begin
    if (RST) begin
        COUNT <= 4'd0;
    end else begin
        COUNT <= n_count;
    end
end
endmodule