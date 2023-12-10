module serial_send_test ();
    logic CLK, RST;
    logic [7:0] DATA_IN;
    logic WE;
    logic DATA_OUT;
    logic BUSY;

    serial_send_circuit # (
        .WAIT_COUNT_BASE(10))
        ser (
        .CLK(CLK),
        .RST(RST),
        .DATA_IN(DATA_IN),
        .WE(WE),
        .DATA_OUT(DATA_OUT),
        .BUSY(BUSY));

    always begin
        CLK <= 1'b1; #10;
        CLK <= 1'b0; #10;
    end

    initial begin
        RST <= 1'b1; #30;
        RST <= 1'b0;
    end

    // 'A'
    assign DATA_IN = 8'h41;

    initial begin
        WE <= 1'b0; #90;
        WE <= 1'b1; #20;
        WE <= 1'b0;
        wait (BUSY == 1'b0); #100;
        $finish;
    end
endmodule