module d_ff(
	input logic [8:0] d,
	input logic EN,clk,rst,
	output logic [8:0] q);
	
always_ff @(posedge clk or posedge rst) begin 
 if (rst)
	q <= 0;
else 
	q<= d;	
end 
endmodule

module d_ff1bit(
	input logic d,
	input logic clk,rst,
	output logic q);
	
always_ff @(posedge clk or posedge rst) begin 
 if (rst)
	q <= 0;
else 
	q<= d;	
end 
endmodule