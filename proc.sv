module proc (
	input logic Mclock,Pclock,rst,run,
	output logic Done,
	output logic [8:0] R0,	R1,	R2,	R3,	R4,	R5,	R6,	R7,	BUS, G_sum, A, G,IR,
	output logic [4:0] ADDRESS,
	output logic [8:0] data,
	output logic [3:0] state);
	
	
upcounter5bit counter (
								.clk(Mclock),
								.rst(rst),
								.ADDRESS(ADDRESS));

ROM MYROM (
				.address(ADDRESS),
				.inclock(Mclock),
				.q(data));
								
datapath datapath1 (
							.clk(Pclock),
							.rst(rst),
							.run(run),
							.DIN(data),
							.Done(Done),
							.R0(R0),	
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
							.G(G),
							.state(state),
							.IR(IR));
				
endmodule 
