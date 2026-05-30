module uart_transmitter_tb;

reg reset,req,clk;
reg [7:0] data;

wire busy,tx;


uart_transmitter dut (.reset(reset),.req(req),.clk(clk),.data(data),.busy(busy),.tx(tx));

always #5 clk=~clk;

initial begin
clk=1;

$monitor("%0t clk=%b reset=%b req=%b data=%b cnt=%b baudcnt=%b shift_reg=%b busy=%b tx=%b",$time,clk,reset,req,data,dut.cnt,dut.baudcnt,dut.shift_reg,busy,tx);
$dumpfile("uart_tx.vcd");
$dumpvars(0,uart_transmitter_tb);

$display("IDLE state");
reset=0;#10;
reset=1;#100;

$display("Data given in idle state");
data=8'b00101001;#50;

$display("Normal transmit operation");
reset=0;#10;
reset=1;#10;
reset=0;#10;
data=8'b10101010;req=1;#10;
req=0;#500;

data=8'b01010101;req=1;#10;
req=0;#500;

$display("Reset mid transmission");
reset=0;#10;
reset=1;#10;
reset=0;#10;
data=8'b10101010;req=1;#10;
req=0;#250;
reset=1;#5;reset=0;#245;

$display("Request and data change mid transmission");
reset=0;#10;
reset=1;#10;
reset=0;#10;
data=8'b10101010;req=1;#10;
req=0;#250;
req=1;#10;req=0;
data=8'b00001111;#10;
req=1;#10;req=0;
#220;



$finish;

end

endmodule
