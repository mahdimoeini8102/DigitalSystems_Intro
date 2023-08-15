`timescale 1ns/1ns

module nand_2in (input a, input b, output w);
	supply1 Vdd;
	supply0 Gnd;
	wire i;
	pmos #(5,6,7) T1(w,Vdd,a);
	pmos #(5,6,7) T2(w,Vdd,b);
	nmos #(3,4,5) T3(w,i,b);
	nmos #(3,4,5) T4(i,Gnd,a);
endmodule



module TB ();
	reg aa;
	reg bb;
	wire ww;
	nand_2in my_ic(aa, bb, ww);
	initial begin
		#10 aa=0;
		#10 bb=1;
		#50 aa=1; //to 0
		#50 aa=0; //to 1
		#50 $stop;
	end
endmodule