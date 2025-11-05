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
			mux4x1 m({inp1[i],inp2[i],inp3[i],inp4[i]},sel,out[i]);
			end 
	endgenerate
endmodule
	
										