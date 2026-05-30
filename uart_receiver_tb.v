module uart_receiver_tb;

reg rx,reset,clk;
wire [7:0] data;

uart_receiver dut (.rx(rx),.reset(reset),.clk(clk),.data(data));

always #5 clk=~clk;

initial begin

clk=1;
rx=1;

$monitor("%0t clk=%b rx=%b reset=%b data=%b idle=%b shift_reg=%b clkcnt=%b cnt=%b",$time,clk,rx,reset,data,dut.idle,dut.shift_reg,dut.clkcnt,dut.cnt);

$dumpfile("uart_rx.vcd");
$dumpvars(0,uart_receiver_tb);

$display("Normal receive operation");

#10;
reset=1;#5;reset=0;#5;
rx=0;#50;

rx=1;#50;
rx=0;#50;
rx=0;#50;
rx=0;#50;
rx=0;#50;
rx=0;#50;
rx=0;#50;
rx=0;#50;

rx=1;#50;



rx=0;#50;

rx=0;#50;
rx=0;#50;
rx=0;#50;
rx=0;#50;
rx=0;#50;
rx=0;#50;
rx=0;#50;
rx=1;#50;

rx=1;#50;



rx=0;#50;

rx=1;#50;
rx=0;#50;
rx=1;#50;
rx=0;#50;
rx=1;#50;
rx=0;#50;
rx=1;#50;
rx=0;#50;

rx=1;#50;



rx=0;#50;

rx=0;#50;
rx=1;#50;
rx=0;#50;
rx=1;#50;
rx=0;#50;
rx=1;#50;
rx=0;#50;
rx=1;#50;

rx=1;#50;
#50;

$display("Reset between receiving");

rx=0;#50;

rx=0;#50;
rx=1;#50;
rx=0;#50;
rx=1;#50;reset=1;
rx=0;#50;
rx=1;#50;
rx=0;#50;
rx=1;#50;

rx=1;#50;
#50;

$finish;


end
endmodule
