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