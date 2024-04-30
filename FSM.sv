module FSM (
	input logic clk, run, rst,
	input logic [8:0] DIN,
	//output logic Done,
	//output logic [8:0] R0,	R2,	R3,	R4,	R5,	R6,	R7,	BUS, G_sum, A, G,
	//input logic [8:0] R1,
	output logic [3:0] state,
	output logic Gout, DINout, IRin, Ain,
	output logic Gin, AddSub, Done,
	output logic R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, 
	output logic R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out,
	output logic [8:0] IR
);
	//logic [8:0] IR;
	/* logic Gout, DINout, IRin, Ain;
	 logic Gin, AddSub;
	 logic R0in, R1in, R2in,R3in, R4in, R5in, R6in, R7in;
	 logic R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out;
	 logic [8:0] IR;

datapath datapath1 (	.IR(IR),	
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
							.G(G));*/


d_ff IR_ff (.d(DIN),.q(IR),.clk(clk),.EN(IRin),.rst(rst));
logic [7:0] outX,outY;
logic RXin,RXout,RYout;


assign R0in = (outX[0] & RXin);
assign R1in = (outX[1] & RXin);
assign R2in = (outX[2] & RXin);
assign R3in = (outX[3] & RXin); 
assign R4in = (outX[4] & RXin);
assign R5in = (outX[5] & RXin);
assign R6in = (outX[6] & RXin);
assign R7in = (outX[7] & RXin);

assign R0out = (outY[0] & RYout) | (outX[0] & RXout);
assign R1out = (outY[1] & RYout)	| (outX[1] & RXout);
assign R2out = (outY[2] & RYout) | (outX[2] & RXout);
assign R3out = (outY[3] & RYout) | (outX[3] & RXout);
assign R4out = (outY[4] & RYout) | (outX[4] & RXout);
assign R5out = (outY[5] & RYout) | (outX[5] & RXout);
assign R6out = (outY[6] & RYout) | (outX[6] & RXout);
assign R7out = (outY[7] & RYout) | (outX[7] & RXout);

decoder decoderRX (.sel(IR[5:3]),.out(outX));
decoder decoderRY (.sel(IR[2:0]),.out(outY));


typedef enum bit [3:0] {reset =4'b0000,
								fetch =4'b0001,
								mv0	=4'b0010,
								mv1 	=4'b0011,
								mvi0	=4'b0100,
								mvi1	=4'b0101,
								mvi2	=4'b0110,
								add0 	=4'b0111,
								add1	=4'b1000,
								add2	=4'b1001,
								add3	=4'b1010,
								sub0 	=4'b1011,
								sub1	=4'b1100,
								sub2	=4'b1101,
								sub3	=4'b1110} state_t;
state_t state_reg, state_next;

always_ff @(posedge clk or posedge rst) begin
	if (rst)
		state_reg <= reset;
	else 
		state_reg <= state_next;
end

always_comb begin
	state_next = state_reg;
	
	case (state_reg)
	reset: begin 
					RXin 	= 1'b0; 
					RXout = 1'b0;
					RYout = 1'b0;
					Gout 	= 1'b0;
					DINout= 1'b0; 
					IRin 	= 1'b0; 
					Ain 	= 1'b0;  
					Gin 	= 1'b0; 
					AddSub= 1'b0; 
					Done	= 1'b0;
						if (rst) 
							state_next = reset;
						else 
							state_next = fetch;
					end
	fetch: begin 
					RXin 	= 1'b0; 
					RXout = 1'b0;
					RYout = 1'b0;
					Gout 	= 1'b0;
					DINout= 1'b0; 
					IRin 	= 1'b1; 
					Ain 	= 1'b0;  
					Gin 	= 1'b0; 
					AddSub= 1'b0; 
					Done 	= 1'b0;
					if ((run == 1'b1) &&  (IR[8:6] == 3'b000))
							state_next = mv0;
						else if ((run == 1'b1) && (IR[8:6] == 3'b001))
							state_next = mvi0;
						else if ((run == 1'b1) && (IR[8:6] == 3'b010))
							state_next = add0;
						else if ((run == 1'b1) && (IR[8:6] == 3'b011))
							state_next = sub0;
			end 	
			
	mv0: begin 
					RXin 	= 1'b0; 
					RXout = 1'b0;
					RYout = 1'b0;
					Gout 	= 1'b0;
					DINout= 1'b0; 
					IRin 	= 1'b0; 
					Ain 	= 1'b0;  
					Gin 	= 1'b0; 
					AddSub= 1'b0; 
					Done 	= 1'b0;
					state_next = mv1;
				end
			
	mv1: begin 
					RXin 	= 1'b1; 
					RXout = 1'b0;
					RYout = 1'b1;
					Gout 	= 1'b0;
					DINout= 1'b0; 
					IRin 	= 1'b0; 
					Ain 	= 1'b0;  
					Gin 	= 1'b0; 
					AddSub= 1'b0; 
					Done 	= 1'b1;
					state_next = fetch;
				end
				
	mvi0: begin 
					RXin 	= 1'b0; 
					RXout = 1'b0;
					RYout = 1'b0;
					Gout 	= 1'b0;
					DINout= 1'b0; 
					IRin 	= 1'b0; 
					Ain 	= 1'b0;  
					Gin 	= 1'b0; 
					AddSub= 1'b0; 
					Done 	= 1'b0;
					state_next = mvi1;
				end
	
	mvi1: begin 
					RXin 	= 1'b1; 
					RXout = 1'b0;
					RYout = 1'b0;
					Gout 	= 1'b0;
					DINout= 1'b0; 
					IRin 	= 1'b0; 
					Ain 	= 1'b0;  
					Gin 	= 1'b0; 
					AddSub= 1'b0; 
					Done 	= 1'b0;
					state_next = mvi2;
				
				end
				
	mvi2: begin 
					RXin 	= 1'b1; 
					RXout = 1'b0;
					RYout = 1'b0;
					Gout 	= 1'b0;
					DINout= 1'b1; 
					IRin 	= 1'b0; 
					Ain 	= 1'b0;  
					Gin 	= 1'b0; 
					AddSub= 1'b0; 
					Done 	= 1'b1;
					state_next = fetch;
				end
	
	
			add0: begin 
					RXin 	= 1'b0;
					RXout = 1'b0;
					RYout = 1'b0;
					Gout 	= 1'b0;
					DINout= 1'b0; 
					IRin 	= 1'b0; 
					Ain 	= 1'b0;  
					Gin 	= 1'b0; 
					AddSub= 1'b0; 
					Done 	= 1'b0;
					state_next = add1;
				end			
				

					
			add1: begin 
					RXin 	= 1'b0;
					RXout = 1'b1;
					RYout = 1'b0;
					Gout 	= 1'b0;
					DINout= 1'b0; 
					IRin 	= 1'b0; 
					Ain 	= 1'b1;  
					Gin 	= 1'b0; 
					AddSub= 1'b0; 
					Done 	= 1'b0;
					state_next = add2;
				end
				

				
		add2: begin 
					RXin 	= 1'b0;
					RXout = 1'b0;
					RYout = 1'b1;
					Gout 	= 1'b0;
					DINout= 1'b0; 
					IRin 	= 1'b0; 
					Ain 	= 1'b0;  
					Gin 	= 1'b1; 
					AddSub= 1'b0; 
					Done 	= 1'b0;
					state_next = add3;
				end
				
		add3: begin 
					RXin 	= 1'b1;
					RXout = 1'b0;
					RYout = 1'b0;
					Gout 	= 1'b1;
					DINout= 1'b0; 
					IRin 	= 1'b0; 
					Ain 	= 1'b0;  
					Gin 	= 1'b0; 
					AddSub= 1'b0; 
					Done 	= 1'b1;
					state_next = fetch;
				end
	
	
	sub0: begin 
					RXin 	= 1'b0;
					RXout = 1'b0;
					RYout = 1'b0;
					Gout 	= 1'b0;
					DINout= 1'b0; 
					IRin 	= 1'b0; 
					Ain 	= 1'b0;  
					Gin 	= 1'b0; 
					AddSub= 1'b0; 
					Done 	= 1'b0;
					state_next = sub1;
				end
								

	sub1: begin 
					RXin 	= 1'b0;
					RXout = 1'b1;
					RYout = 1'b0;
					Gout 	= 1'b0;
					DINout= 1'b0; 
					IRin 	= 1'b0; 
					Ain 	= 1'b1;  
					Gin 	= 1'b0; 
					AddSub= 1'b0; 
					Done 	= 1'b0;
					state_next = sub2;
				end
				
	sub2: begin 
					RXin 	= 1'b0;
					RXout = 1'b0;
					RYout = 1'b1;
					Gout 	= 1'b0;
					DINout= 1'b0; 
					IRin 	= 1'b0; 
					Ain 	= 1'b0;  
					Gin 	= 1'b1; 
					AddSub= 1'b1; 
					Done 	= 1'b0;
					state_next = sub3;
				end
				
	sub3: begin 
					RXin 	= 1'b1;
					RXout = 1'b0;
					RYout = 1'b0;
					Gout 	= 1'b1;
					DINout= 1'b0; 
					IRin 	= 1'b0; 
					Ain 	= 1'b0;  
					Gin 	= 1'b0; 
					AddSub= 1'b0; 
					Done 	= 1'b1;
					state_next = fetch;
				end
endcase 			
end

assign state = state_reg;

endmodule


