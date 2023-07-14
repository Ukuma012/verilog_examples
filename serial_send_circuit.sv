module serial_send_circuit (
    input logic CLK, RST,
    input logic [7:0] DATA_IN,
    input logic WE,
    output logic DATA_OUT,
    output logic BUSY
);

parameter WAIT_COUNT_BASE = 868; // Tser(115.2kbps) / Tclk(0.01μs)
localparam WAIT_LEN = $clog2(WAIT_COUNT_BASE);

typedef enum{
    STATE_IDLE,
    STATE_SEND
} state_type;

state_type state, next_state;
logic [9:0] data_reg, next_data_reg;
logic [WAIT_LEN - 1: 0] wait_count, next_wait_count;
logic [3:0] bit_count, next_bit_count;

assign DATA_OUT = data_reg[0];

always_comb begin
    BUSY = 1'b0;
    next_state = state;
    next_wait_count = wait_count;
    next_bit_count = bit_count;
    next_data_reg = data_reg;
    if (state == STATE_IDLE) begin
        if (WE) begin
            next_state = STATE_SEND;
            next_data_reg = {1'b1, DATA_IN, 1'b0};
        end
    end else if (state == STATE_SEND) begin
        BUSY = 1'b1;
        if (wait_count == WAIT_COUNT_BASE - 1) begin
            if (bit_count == 4'b9) begin
                next_state = STATE_IDLE;
                next_wait_count = 0;
                next_bit_count = 4'd0; 
            end else begin
                next_data_reg = {1'b1, data_reg[9:1]}
                next_wait_count = 0;
                next_bit_count = bit_count + 1'b1;
            end
        end else begin
            next_wait_count = wait_count + 1'b1;
        end
    end
end

always always_ff @( CLK ) begin
    if (RST) begin
        state <= STATE_IDLE;
        wait_count <= 0;
        bit_count <= 4'd0;
        data_reg <= 10'h3ff;
    end else begin
        state <= next_state;
        wait_count <= next_wait_count;
        bit_count <= next_bit_count;
        data_reg <= next_data_reg;
    end
end
endmodule