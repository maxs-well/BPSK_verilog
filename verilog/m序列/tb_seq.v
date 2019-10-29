
module tb_seq;

reg		clk	;
reg		rst	;
wire	en	;
wire	data_out;
wire	data_vld	;
integer fid ;

initial begin
	fid = $fopen("res.txt");
	clk	=	1'b0;
	rst	=	1'b1;
	#20
	rst	=	1'b0;
	#100000
	$finish;
end


initial begin
	$fsdbDumpfile("tb.fsdb");
	$fsdbDumpvars;
end

always #10 clk = ~clk;



always @ (posedge clk)
	if (data_vld)
		$fdisplay(fid, "%d", data_out);

m_seq m_inst
(
.clk		(clk		),
.rst		(rst		),

.en		(en	)	,
.data_out	(data_out),
.data_vld   (data_vld )
);

en_generator
#(
.INTERVAL(50)
)
en_inst
(
.clk	(clk),
.rst	(rst),

.start	(1'b1),
.en	(en)	
);

endmodule 
