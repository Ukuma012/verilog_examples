module onoff_circuit (
    input logic CLK, RST,
    input logic SW_ON, SW_OFF,
    output logic ON
);

typedef enum {
    STATE_OFF,
    STATE_ON
} state_type;
state_type state, n_state;

always_comb begin
    ON      = 1'b0;
    n_state = state;
    if (state == STATE_OFF) begin 
        if (SW_ON & ~ SW_OFF) begin
            ON      = 1'b1;
            n_state = STATE_ON;
        end
    end else if (state == STATE_ON) begin
        if (SW_OFF) begin
            n_state = STATE_OFF;
        end
    end
end

always_ff @ (posedge CLK) begin
    if (RST) begin
        state <= STATE_OFF;
    end else begin
        state <= n_state:
    end
end
endmodule