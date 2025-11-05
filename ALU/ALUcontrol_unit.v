module ALUcontrol_unit(input [1:0] ALUop ,
										 input [4:0] F,
										 output [2:0] Operation
										 );
	assign Operation[2]= ALUop[0]  | (ALUop[1] & F[1]);
	assign Operation[1]= ~ALUop[1] | ~F[2] ;
	assign Operation[0] = ALUop[1] & (F[3] | F[0]);
	
	endmodule