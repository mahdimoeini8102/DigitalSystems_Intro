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

module nand_3in (input a, input b, input c, output w);
	supply1 Vdd;
	supply0 Gnd;
	wire i,j;
	pmos #(5,6,7) T1(w,Vdd,a);
	pmos #(5,6,7) T2(w,Vdd,b);
	pmos #(5,6,7) T3(w,Vdd,c);
	nmos #(3,4,5) T4(w,i,c);
	nmos #(3,4,5) T5(i,j,b);
	nmos #(3,4,5) T6(j,Gnd,a);
endmodule

module nand_4in (input a, input b, input c, input d, output w);
	supply1 Vdd;
	supply0 Gnd;
	wire i,j,k;
	pmos #(5,6,7) T1(w,Vdd,a);
	pmos #(5,6,7) T2(w,Vdd,b);
	pmos #(5,6,7) T3(w,Vdd,c);
	pmos #(5,6,7) T4(w,Vdd,d);
	nmos #(3,4,5) T5(w,i,d);
	nmos #(3,4,5) T6(i,j,c);
	nmos #(3,4,5) T7(j,k,b);
	nmos #(3,4,5) T8(k,Gnd,a);
endmodule

module mux_4to1 (input s0, input s1, input a, input b, input c, input d, output w);
	supply1 Vdd;
	supply0 Gnd;
	wire ns0, ns1, o1, o2, o3, o4;
	
	nand_2in nand1(s0,s0,ns0);
	nand_2in nand2(s1,s1,ns1);
	
	nand_3in nand3(a,ns1,ns0,o1);
	nand_3in nand4(b,ns1, s0,o2);
	nand_3in nand5(c, s1,ns0,o3);
	nand_3in nand6(d, s1, s0,o4);
	
	nand_4in nand7(o1,o2,o3,o4,w);
endmodule

module TB ();
	reg aa,bb,cc,dd,ss0,ss1;
	wire ww;
	mux_4to1 my_ic(ss0, ss1, aa, bb, cc, dd, ww);
	initial begin
		#100 ss0=0;ss1=0;aa=0;bb=1;cc=1;dd=0; //Initialize (t=100)
		#100 ss0=1;
		#100 ss0=0;ss1=0;aa=0;bb=1;cc=1;dd=0; //Reinitialize (t=300)
		#100 ss1=1;
		#100 ss0=1;ss1=0;aa=0;bb=1;cc=1;dd=0; //Reinitialize (t=500)
		#100 ss0=0;
		#100 ss0=1;ss1=0;aa=0;bb=1;cc=1;dd=0; //Reinitialize (t=700)
		#100 ss1=1;
		#100 ss0=0;ss1=1;aa=0;bb=1;cc=1;dd=0; //Reinitialize (t=900)
		#100 ss0=1;
		#100 ss0=0;ss1=1;aa=0;bb=1;cc=1;dd=0; //Reinitialize (t=1100)
		#100 ss1=0;
		#100 ss0=1;ss1=1;aa=0;bb=1;cc=1;dd=0; //Reinitialize (t=1300)
		#100 ss0=0;
		#100 ss0=1;ss1=1;aa=0;bb=1;cc=1;dd=0; //Reinitialize (t=1500)
		#100 ss1=0;
		#100 $stop;
	end
endmodule