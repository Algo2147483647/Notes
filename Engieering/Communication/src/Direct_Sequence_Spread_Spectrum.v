module LedTest(
input clk,rst,
output reg[15:0] data
);
	reg[3:0] clk_sign;
	wire[15:0] sign;
	wire m_key;
	always@(posedge clk or negedge rst)
	begin
		if(!rst)
			clk_sign <= 10'd0;	
		else if(clk_sign == 10'd4)
			clk_sign <= 10'd0;
		else
			clk_sign <= clk_sign + 10'd1;
			
		if(m_key==1)
			data <= ~sign;
		else 
			data <= sign;
	end
	DDS DDS_1
	(
		.rst (rst),
		.clk (clk_sign),
		.data (sign)
	);
	M_Seq M_Seq_1
	(
		.rst (rst),
		.clk (clk),
		.out (m_key)
	);
endmodule

module M_Seq#(
	parameter
	n = 4 //N = 2^n - 1
)(
	input clk,rst,
	output wire out
);
	reg[n-1:0] sk;
	reg[n-1:0] ck;
	assign out = sk[n-1];
	always@(posedge clk or negedge rst)
	begin
		if(!rst)
			sk = 4'b1111;
		else begin
			sk <= (sk << 1'b1);
			sk[0] <= (~sk[n-1]&sk[0]) | (sk[n-1]& ~sk[0]);
		end
	end
endmodule

module DDS(
	input clk,rst,
	output[15:0] data
);
	reg[9:0] addr=10'd0;
	ROM_10x1024 Rom_0(
		.RomAddr(addr),
		.RomData(data)
	);
	always@(posedge clk or negedge rst)
	begin
		if(!rst)
			addr <= 10'd0;	
		else if(addr == 10'd1023)
			addr <= 10'd0;
		else
			addr <= addr + 10'd1;
	end
endmodule

module ROM_10x1024(
	output[15:0] RomData,
	input[9:0] RomAddr
);
	reg [15:0]Rom[1023:0];
	assign RomData=Rom[RomAddr];
	initial $readmemb("D:/VerilogTest/txt.txt",Rom,0,1023);
endmodule

