
module bit8adder( 
	input logic [8:0] a,b,
	input logic cin,
	output logic [8:0] out);
	logic [8:0] cary;
	
adder adder1 (
					.a(a[0]),
					.b(b[0]^cin),
					.cin(cin),
					.cout(cary[0]),
					.sum(out[0]));


adder adder2 (
					.a(a[1]),
					.b(b[1]^cin),
					.cin(cary[0]),
					.cout(cary[1]),
					.sum(out[1]));


adder adder3 (
					.a(a[2]),
					.b(b[2]^cin),
					.cin(cary[1]),
					.cout(cary[2]),
					.sum(out[2]));

adder adder4 (
					.a(a[3]),
					.b(b[3]^cin),
					.cin(cary[2]),
					.cout(cary[3]),
					.sum(out[3]));


adder adder5 (
					.a(a[4]),
					.b(b[4]^cin),
					.cin(cary[3]),
					.cout(cary[4]),
					.sum(out[4]));			
				
adder adder6 (
					.a(a[5]),
					.b(b[5]^cin),
					.cin(cary[4]),
					.cout(cary[5]),
					.sum(out[5]));
					
adder adder7 (
					.a(a[6]),
					.b(b[6]^cin),
					.cin(cary[5]),
					.cout(cary[6]),
					.sum(out[6]));	
					
adder adder8 (
					.a(a[7]),
					.b(b[7]^cin),
					.cin(cary[6]),
					.cout(cary[7]),
					.sum(out[7]));
					
adder adder9 (
					.a(a[8]),
					.b(b[8]^cin),
					.cin(cary[7]),
					.cout(cary[8]),
					.sum(out[8]));
					
endmodule 
					

module adder ( 
		input logic a, b, cin,
		output logic cout, sum);
		
		assign cout = (a & b)  | ((a ^ b ) & cin);
		assign sum = a ^ b ^ cin;
endmodule 