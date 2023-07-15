module serial_fpga (
	input logic CLK, RST,
	output logic TXD);

	typedef enum {
		STATE_SEND,
		STATE_WAIT,
		STATE_FIN
	} state_type;

	state_type state, next_state;
	logic WE;
	logic BUSY;
	logic [7:0] DATA_IN;

	serial_send_circuit # (
			.WAIT_COUNT_BASE(868))
		ser (
			.CLK(CLK),
			.RST(RST),
			.DATA_IN(DATA_IN),
			.WE(WE),
			.DATA_OUT(TXD),
			.BUSY(BUSY));
	
	assign DATA_IN = 8'h41;

	always_comb begin
		next_state = state;
		WE = 1'b0;
		if (state == STATE_SEND) begin
			next_state = STATE_WAIT;
			WE = 1'b1;
		end else if (state == STATE_WAIT) begin
			if (~ BUSY) begin
				next_state = STATE_FIN;
			end
		end
	end

	always_ff @ (posedge CLK) begin
		if (RST) begin
			state <= STATE_SEND;
		end else begin
			state <= next_state;
		end
	end
endmodule
