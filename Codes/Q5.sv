`timescale 1ns/1ns

module TSB (input in, input en, output ou);
	supply1 Vdd;
	supply0 Gnd;
	wire i,j,k;
	pmos #(5,6,7) T1(j,Vdd,in), T2(ou,j,i), T3(i,Vdd,en);
	nmos #(3,4,5) T4(i,Gnd,en), T5(ou,k,en), T6(k,Gnd,in);
endmodule

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





module mux_4to1_Q3 (input s0, input s1, input a, input b, input c, input d, output w);
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

module mux_4to1_Q4 (input s0, input s1, input a, input b, input c, input d, output w);
	supply1 Vdd;
	supply0 Gnd;
	wire ns0, ns1, nab, ncd;

	TSB tsb1(a,ns0,nab);
	TSB tsb2(b, s0,nab);
	TSB tsb3(c,ns0,ncd);
	TSB tsb4(d, s0,ncd);
	TSB tsb5(s0,Vdd,ns0);
	TSB tsb6(nab,ns1,w);
	TSB tsb7(ncd, s1,w);
	TSB tsb8(s1,Vdd,ns1);

endmodule

module TB ();
	reg a3,b3,c3,d3,s03,s13;
	wire w3;
	reg a4,b4,c4,d4,s04,s14;
	wire w4;
	mux_4to1_Q3 ic_Q3(s03, s13, a3, b3, c3, d3, w3);
	mux_4to1_Q4 ic_Q4(s04, s14, a4, b4, c4, d4, w4);
	initial begin
		#100 s03=0;s13=0;a3=0;b3=1;c3=1;d3=0; //Initialize Q3 (t=100)
			 s04=0;s14=0;a4=0;b4=1;c4=1;d4=0; //Initialize Q4 (t=100)
		#100 s03=1;s04=1;
		
		#100 s03=0;s13=0;a3=0;b3=1;c3=1;d3=0; //Reinitialize Q3 (t=300)
			 s04=0;s14=0;a4=0;b4=1;c4=1;d4=0; //Reinitialize Q4 (t=300)
		#100 s13=1;s14=1;
		
		#100 s03=1;s13=0;a3=0;b3=1;c3=1;d3=0; //Reinitialize Q3 (t=500)
			 s04=1;s14=0;a4=0;b4=1;c4=1;d4=0; //Reinitialize Q4 (t=500)
		#100 s03=0;s04=0;
		
		#100 s03=1;s13=0;a3=0;b3=1;c3=1;d3=0; //Reinitialize Q3 (t=700)
			 s04=1;s14=0;a4=0;b4=1;c4=1;d4=0; //Reinitialize Q4 (t=700)
		#100 s13=1;s14=1;
		
		#100 s03=0;s13=1;a3=0;b3=1;c3=1;d3=0; //Reinitialize Q3 (t=900)
			 s04=0;s14=1;a4=0;b4=1;c4=1;d4=0; //Reinitialize Q4 (t=900)
		#100 s03=1;s04=1;
		
		#100 s03=0;s13=1;a3=0;b3=1;c3=1;d3=0; //Reinitialize Q3 (t=1100)
			 s04=0;s14=1;a4=0;b4=1;c4=1;d4=0; //Reinitialize Q4 (t=1100)
		#100 s13=0;s14=0;
		
		#100 s03=1;s13=1;a3=0;b3=1;c3=1;d3=0; //Reinitialize Q3 (t=1300)
			 s04=1;s14=1;a4=0;b4=1;c4=1;d4=0; //Reinitialize Q4 (t=1300)
		#100 s03=0;s04=0;
		
		#100 s03=1;s13=1;a3=0;b3=1;c3=1;d3=0; //Reinitialize Q3 (t=1500)
			 s04=1;s14=1;a4=0;b4=1;c4=1;d4=0; //Reinitialize Q4 (t=1500)
		#100 s13=0;s14=0;
		#100 $stop;
		//We could have made our work easier and used s0 instead of s03 & s04 for example.
	end
endmodule