//from intel altera
module pc2mem
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=16)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] read_addr, write_addr,
	input we, clk,
	output reg [(DATA_WIDTH-1):0] q
);



	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] image[2**ADDR_WIDTH-1:0];
	initial $readmemh("lenaword.hex", image);

	
	always @ (posedge clk)
	begin
		// Write
		if (we)
			image[write_addr] <= data;
	end
	
	always @ (posedge clk)
	begin
		// Read 
		q <= image[read_addr];
	end
	
endmodule