module uart_receiver (clk, rx, data, reset);

input rx,reset,clk;
output reg [7:0] data;

reg [7:0] shift_reg;
reg [2:0] clkcnt;
reg idle;
reg [3:0] cnt;

parameter baud_rate=2.212, clk_freq=11.0592; //in MHz
parameter clks_per_bit=5;
parameter bit_center=3;

always @(posedge clk) begin //1

if (reset==1 || (cnt==9 && clkcnt==clks_per_bit)) begin//4
	idle<=1;
	clkcnt<=1;
	cnt<=0;
	shift_reg<=0;
end //4
else if (reset==0) begin //2

	if (rx==0 && idle==1) begin //3
		idle<=0;
	end//3

	if (idle==0) clkcnt<=clkcnt+1;
	
	if (clkcnt == bit_center) begin //5
		cnt<=cnt+1;
		if (cnt>0 && cnt<9) begin //6
			shift_reg[7]<=rx;
		end //6 
	end//5

	if (clkcnt==clks_per_bit) begin //7
		clkcnt<=1;
		if (cnt!=9) shift_reg<=shift_reg>>1;
	end //7

	if (cnt==9) data<=shift_reg;

	
end //2
end //1

endmodule