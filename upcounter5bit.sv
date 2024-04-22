module upcounter5bit (
	input logic clk,rst,
	output logic [4:0] ADDRESS);
	
	d_ff1bit ff1 (
						.clk(clk),
						.rst(rst),
						.d(~ADDRESS[0]),
						.q(ADDRESS[0]));
						
	d_ff1bit ff2 (
						.clk(~ADDRESS[0]),
						.rst(rst),
						.d(~ADDRESS[1]),
						.q(ADDRESS[1]));
						
	d_ff1bit ff3 (
						.clk(~ADDRESS[1]),
						.rst(rst),
						.d(~ADDRESS[2]),
						.q(ADDRESS[2]));
						
	d_ff1bit ff4 (
						.clk(~ADDRESS[2]),
						.rst(rst),
						.d(~ADDRESS[3]),
						.q(ADDRESS[3]));
						
						
	d_ff1bit ff5 (
						.clk(~ADDRESS[3]),
						.rst(rst),
						.d(~ADDRESS[4]),
						.q(ADDRESS[4]));
						
endmodule 