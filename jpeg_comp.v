//from intel altera
module jpeg_comp
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=16)
(	input clk, 
   input ares, 
	input sres,
	output wire [(DATA_WIDTH-1):0] q
	
);

	//TO DO : We want a ping pong buffer that reads 8x8 blocks and writes them
	//word size = 32 bits, so 4 pixels at a time
	reg [(8*8) -1 :0] ping_buff;
	reg [(8*8) -1 :0] pong_buff;
	reg [ADDR_WIDTH - 1:0] read_addr_cnt;
	always@(posedge clk, negedge ares)begin 
		if(~ares)begin
			read_addr_cnt <=0;
		end
		else if (sres) begin
			read_addr_cnt <= 0;
		end
		else begin 		
			read_addr_cnt <= read_addr_cnt + 1;		
		end
	end
	





	wire [(DATA_WIDTH-1):0] data;
	wire [(ADDR_WIDTH-1):0] read_addr, write_addr;
	wire we;
	assign read_addr= 16'b0;
	pc2mem #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH))read_image
		( .data(data),
		  .read_addr(read_addr),
		  .write_addr(write_addr),
		  .we(1'b0),
		  .clk(clk),
		  .q(q)
		);
	
	
	
endmodule