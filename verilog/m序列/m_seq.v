// %======================================================
// % author： woodfan
// % function： 生成m序列
// % step：   
// % 根据coef确定周期len
// % 例如： coef 19 10011
// %  output   <---
// %              |
// %             d4  <--  d3 <-- d2 <-- d1 <-----        
// %              |                      |      |
// %           C4 |      C3     C2     C1|      | C0
// %              |_________+____________|      |
// %                        |                   |
// %                        -----cal_data--------
// %======================================================   

module m_seq
(
	input							clk		,
	input							rst		,

	input							en		,
	output	reg						data_out,
	output	reg						data_vld
);

reg [3:0]	data_count = 4'b1000	;


always @ (posedge clk or posedge rst)
begin
	if (rst)
	begin
		data_out	<=	1'b0;
		data_vld	<=	1'b0;
		data_count	<=	4'b1000	;
	end
	else if (en)
	begin
		data_out	<=	data_count[0];
		data_count[2:0]	<=	data_count[3:1];
		data_count[3]	<=	data_count[0] ^ data_count[3];
		data_vld	<=	1'b1;
	end
	else
	begin
		data_vld	<=	1'b0;
	end
end

endmodule
