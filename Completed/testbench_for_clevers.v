module testbench_for_clevers;

reg [31:0] address, data;
reg mode, clk;
wire [31:0] out;

cache_no_mode_clever cache();

cache_and_ram_clever_tb tb(
	.address(address),
	.data(data),
	.mode(mode),
	.clk(clk),
	.out(out)
);

initial
begin
	clk = 1'b1;
	
	address = 32'b00000000000000000000000000000000;			// 0
	data =    32'b00000000000000000011100011000000;			// 14528
	mode = 1'b1;
	
	#200
	address = 32'b10100111111001011111101111011100;			// 2816867292 % size = 3036
	data =    32'b00000000000010000000100001010101;			// 526421
	mode = 1'b1;
	
	#200
	address = 32'b00000000000000000000000000000000;			// 0
	data =    32'b00000000000000000011100011000000;			// 14528
	mode = 1'b0;
	
	#200
	address = 32'b10100111111001011111101111011100;			// 2816867292 % size = 3036
	data =    32'b00000000000010000000100001010101;			// 526421
	mode = 1'b0;
	
	#200
	address = 32'b00000000000011110100011111010001;			// 1001425 % size = 2001
	data =    32'b00000001100000110001101100010110;			// 25369366
	mode = 1'b1;

	#200
	address = 32'b00000000000011110100011111010001;			// 1001425 % size = 2001
	data =    32'b00000001100000110001101100010110;			// 25369366
	mode = 1'b0;

	#200
	address = 32'b10100111111001011111101111011100;			// 2816867292 % size = 3036
	data =    32'b00000000000000000011100011000000;			// 14528
	mode = 1'b1;

	#200
	address = 32'b00000000000011110100011111010001;			// 1001425 % size = 2001
	data =    32'b00000000000000000011100011000000;			// 14528
	mode = 1'b1;

	#200
	address = 32'b00000000000011110100011111010001;			// 1001425 % size = 2001
	data =    32'b00000000000000000000000000000000;			// 0
	mode = 1'b0;
	
	#200
	address = 32'b10100111111001011111101111011100;			// 2816867292 % size = 3036
	data =    32'b00000000000000000000000000000000;			// 0
	mode = 1'b0;
end

initial
$monitor("address = %d data = %d mode = %d out = %d cache = %d index = %b valid_array = %b response_ram = %b prev_response = %b missrate = %b prev_address = %d ram = %d", address % 4096, data, mode, out, tb.cache.cache[tb.cache.index], tb.cache.index, tb.cache.valid_array[tb.cache.index], tb.cache.response_ram, tb.cache.prev_response, tb.cache.missrate, tb.cache.prev_address, tb.ram.ram[tb.cache.prev_address]);

always #25 clk = ~clk;

endmodule
