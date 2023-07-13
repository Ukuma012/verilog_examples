module serial_send_circuit (
    input logic CLK, RST,
    input logic [7:0] DATA_IN,
    input logic WE,
    output logic DATA_OUT,
    output logic BUSY
);