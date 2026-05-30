module uart_transmitter (clk, reset, req, data, busy, tx);

input reset, req, clk;
input [7:0] data;
output reg busy, tx;

reg [3:0] cnt;
reg [10:0] baudcnt;
reg [7:0] shift_reg;

parameter baud_rate=2.212, clk_freq=11.0592; //in MHz
parameter clks_per_bit=5;


always @(posedge clk) begin

if (reset==1) begin 
	tx<=1;
	cnt<=0;
	baudcnt<=0;
	shift_reg<=0;
	busy<=0;
end

else begin
	if (req==1 && busy==0) begin
		busy<=1;
		shift_reg<=data;
	end

	if (busy==1) begin

		if (baudcnt < clks_per_bit-1) begin
			baudcnt<=baudcnt+1;

			if (cnt == 0) begin
				tx<=0;
			end

			if (cnt==9) begin
				tx<=1;
			end

			if (cnt>0 && cnt<9) begin
				tx<=shift_reg[0];
			end

		end

		else if (baudcnt==clks_per_bit-1) begin

			baudcnt<=0;
			if (cnt>0 && cnt<9) begin 
				shift_reg<=shift_reg>>1;
			end

			cnt<=cnt+1;
				
		end

	if (cnt==4'd10) begin
		busy<=0;
		tx<=1;
		cnt<=0;
		baudcnt<=0;
		shift_reg<=0;
	end

	if (busy==0) begin
		tx<=1;
		cnt<=0;
		baudcnt<=0;
		shift_reg<=0;
	end

	end

end

end


endmodule