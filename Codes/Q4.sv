`timescale 1ns/1ns

module TSB (input in, input en, output ou);
	supply1 Vdd;
	supply0 Gnd;
	wire i,j,k;
	pmos #(5,6,7) T1(j,Vdd,in), T2(ou,j,i), T3(i,Vdd,en);
	nmos #(3,4,5) T4(i,Gnd,en), T5(ou,k,en), T6(k,Gnd,in);
endmodule

module mux_4to1 (input s0, input s1, input a, input b, input c, input d, output w);
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