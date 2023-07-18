## Clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { CLK }]; 
create_clock -add -name sys_clk_pin -period 10.00 [get_ports { CLK }];

## Buttons
set_property -dict { PACKAGE_PIN D9   IOSTANDARD LVCMOS33 } [get_ports { RST }]; 

## USB-UART Interface
set_property -dict { PACKAGE_PIN D10    IOSTANDARD LVCMOS33 } [get_ports { TXD }]; 
