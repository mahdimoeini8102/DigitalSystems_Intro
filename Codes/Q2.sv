`timescale 1ns/1ns

module TSB (input a, input en, output w);
	supply1 Vdd;
	supply0 Gnd;
	wire i,j,k;
	pmos #(5,6,7) T1(j,Vdd,a), T2(w,j,i), T3(i,Vdd,en);
	nmos #(3,4,5) T4(i,Gnd,en), T5(w,k,en), T6(k,Gnd,a);
endmodule



module TB ();
	reg aa;
	reg enen;
	wire ww;
	TSB my_ic(aa, enen, ww);
	initial begin
		#10 aa=0; enen=0; //Initialize
		#30 enen=1; //to 1 (from Z)
		#30 aa=1;   //to 0 (from 1)
		#30 aa=0; enen=1;   //Restart Initialize
		#30 enen=0; //to z (from 1)
		#30 $stop;
	end
endmodule