module combined_tb;

reg reset,clk,req;
reg [7:0] txdata;

wire busy,tx;
wire [7:0] rxdata;


uart_transmitter utx (.reset(reset),.req(req),.clk(clk),.data(txdata),.busy(busy),.tx(tx));

uart_receiver urx (.reset(reset),.clk(clk),.rx(tx),.data(rxdata));

always #5 clk=~clk;

initial begin
clk=1;

$monitor("%0t clk=%b txdata=%h rxdata=%h busy=%b tx=%b",$time,clk,txdata,rxdata,busy,tx);
#10;
reset=1;#5;reset=0;#5;

txdata=8'h01;req=1;
#10;
req=0;

wait(busy==0);
#10;

txdata=8'h80;req=1;
#10;
req=0;

wait(busy==0);
#10;

txdata=8'h55;req=1;
#10;
req=0;

wait(busy==0);
#10;

txdata=8'haa;req=1;
#10;
req=0;

wait(busy==0);
#10;

$finish;

end
endmodule
