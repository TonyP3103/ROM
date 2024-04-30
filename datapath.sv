module datapath (
	input logic [8:0] DIN,
	input logic rst,clk,run, 
	output logic Done,
	output logic [3:0] state,
	output logic [8:0] R0,	R1,	R2,	R3,	R4,	R5,	R6,	R7,	BUS, G_sum, A, G,IR);
	
	
	logic R0out,	R1out,	R2out,	R3out,	R4out,	R5out,	R6out,	R7out; 
	logic R0in,		R1in,		R2in,		R3in,		R4in,		R5in,		R6in,		R7in,IRin;
	 logic Ain,	AddSub,	Gin, DINout, Gout;
	FSM FSM1 (			.Done(Done),
							.DIN(DIN),
							.rst(rst),
							.clk(clk),
							.R0out(R0out),	
							.R1out(R1out),	
							.R2out(R2out),	
							.R3out(R3out),
							.R4out(R4out),	
							.R5out(R5out),
							.R6out(R6out),
							.R7out(R7out),
							.R0in(R0in),	
							.R1in(R1in),
							.R2in(R2in),
							.R3in(R3in),
							.R4in(R4in),
							.R5in(R5in),
							.R6in(R6in),
							.R7in(R7in),
							.Ain(Ain),
							.AddSub(AddSub),
							.Gin(Gin),
							.IRin(IRin),
							.DINout(DINout),
							.Gout(Gout),
							.state(state),
							.run(run),
							.IR(IR)
							/*.R0(R0),	
							.R1(R1),	
							.R2(R2),
							.R3(R3),
							.R4(R4),
							.R5(R5),
							.R6(R6),
							.R7(R7),
							.BUS(BUS),
							.G_sum(G_sum),
							.A(A),
							.G(G)*/);
	
	
	


d_ff R0_ff (.d(BUS),.q(R0),.clk(clk),.EN(R0in),.rst(rst));

d_ff R1_ff (.d(BUS),.q(R1),.clk(clk),.EN(R1in),.rst(rst));

d_ff R2_ff (.d(BUS),.q(R2),.clk(clk),.EN(R2in),.rst(rst));

d_ff R3_ff (.d(BUS),.q(R3),.clk(clk),.EN(R3in),.rst(rst));

d_ff R4_ff (.d(BUS),.q(R4),.clk(clk),.EN(R4in),.rst(rst));

d_ff R5_ff (.d(BUS),.q(R5),.clk(clk),.EN(R5in),.rst(rst));

d_ff R6_ff (.d(BUS),.q(R6),.clk(clk),.EN(R6in),.rst(rst));

d_ff R7_ff (.d(BUS),.q(R7),.clk(clk),.EN(R7in),.rst(rst));
	
d_ff A_ff (.d(BUS),.q(A),.EN(Ain),.clk(clk),.rst(rst));

bit8adder bit8adder1 (.a(A),.b(BUS),.cin(AddSub),.out(G_sum));

d_ff G_ff_ff (.d(G_sum),.q(G),.EN(Gin),.clk(clk),.rst(rst));


mux mux1 (
				.clk(clk),
				.R0(R0),
				.R1(R1),
				.R2(R2),
				.R3(R3),
				.R4(R4),
				.R5(R5),
				.R6(R6),
				.R7(R7),
				.DIN(DIN),
				.G(G),
				.R0out(R0out),
				.R1out(R1out),
				.R2out(R2out),
				.R3out(R3out),
				.R4out(R4out),
				.R5out(R5out),
				.R6out(R6out),
				.R7out(R7out),
				.DINout(DINout),
				.Gout(Gout),
				.BUS(BUS));
endmodule 
