module bit32AND (out,in1,in2);
input [31:0] in1,in2;
output [31:0] out;
assign {out}=in1 & in2;
endmodule

module bit32OR(out,in1,in2);
	input [31:0] in1,in2;
	output [31:0] out;
	assign {out}=in1 | in2;
endmodule

module mux2to1(
	output out,
	input select,
	input a,
	input b
	);
assign out = select?b:a;
endmodule



module  bit32_2to1mux(output [31:0] out,
									 input sel,
									 input [31:0] in1,
									 input [31:0] in2
									 );
	generate 	genvar i;
		for(i=0;i<32;i=i+1) begin : mux
			mux2to1 m0(out[i],sel,in1[i],in2[i]);
	end 
endgenerate
endmodule


module  mux4x1(input [3:0] data, input [1:0] select, output q);
	wire [1:0]seln;
	not n1(seln[1],select[1]);
	not n2(seln[0],select[0]);
	wire [3:0] a;
	and a0(a[0],data[0],seln[0],seln[1]);
	and a1(a[1],data[1],select[0],seln[1]);
	and a2(a[2],data[2],seln[0],select[1]);
	and a3(a[3],data[3],select[0],select[1]);
	or or1(q,a[0],a[1],a[2],a[3]);
endmodule

module bit32_4to1mux( input [31:0] inp1,
									    input [31:0] inp2,
										input [31:0] inp3,
										input [31:0] inp4,
										input [1:0] sel,
										output [31:0] out);
	generate 
	 genvar i;
		for(i=0;i<32;i=i+1) begin :mux
			mux4x1 m({inp4[i],inp3[i],inp2[i],inp1[i]},sel,out[i]);
			end 
	endgenerate
endmodule
	

module FA_dataflow (Cout, Sum,In1,In2,Cin);
input [31:0]In1;
input [31:0]In2;
input Cin;
output Cout;
output [31:0] Sum;
assign {Cout,Sum}=In1+In2+Cin;
endmodule

module ALU( input [31:0] a,
					   input [31:0]b,
					   input Binvert,
					   input Carryin,
					   input [1:0] Op,
					   output [31:0] Result,
					   output Carryout
					   );
					  
			wire [31:0] muxin [2:0] ;
			wire [31:0] bout;
			wire [31:0] zero;
			assign zero=32'h0000;
			
			bit32_2to1mux FAb(bout,Binvert,b,~b);
			bit32AND a1(muxin[0],a,bout);
			bit32OR a2(muxin[1],a,bout);
			FA_dataflow a3(Carryout,muxin[2],a,bout,Carryin);
			bit32_4to1mux res(muxin[0],muxin[1],muxin[2],zero,Op,Result);
endmodule
			
			
