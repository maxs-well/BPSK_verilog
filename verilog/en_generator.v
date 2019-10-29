module en_generator
#(
parameter	INTERVAL = 10
)
(
input						clk	,
input						rst	,

input						start	,
output	reg					en	
);

reg [31:0] count;

always @ (posedge clk or posedge rst)
begin
	if (rst)
	begin
		count	<=	'd0;
		en	<=	1'b0;
	end
	else if (start)
	begin
		if (count < INTERVAL)
		begin
			count	<=	count	+	32'd1;
			en	<=	1'b0;
		end
		else
		begin
			count	<=	'd0;
			en	<=	1'b1;
		end
	end
end

endmodule 
