`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:26:15 04/19/2018 
// Design Name: 
// Module Name:    alphabet 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alphabet(
	 input RESET,
    input Clk,
    input LONG,
    input SHORT,
	 input END_CHAR,
    output [4:0] LETTER,
    output STROBE
    );
	 
reg[4:0] STATE, LETTER;
reg STROBE;

	 
localparam
	INIT = 5'b00000,
	A = 5'b00001,
	B = 5'b00010,
	C = 5'b00011,
	D = 5'b00100,
	E = 5'b00101,
	F = 5'b00110,
	G = 5'b00111,
	H = 5'b01000,
	I = 5'b01001,
	J = 5'b01010,
	K = 5'b01011,
	L = 5'b01100,
	M = 5'b01101,
	N = 5'b01110,
	O = 5'b01111,
	P = 5'b10000,
	Q = 5'b10001,
	R = 5'b10010,
	S = 5'b10011,
	T = 5'b10100,
	U = 5'b10101,
	V = 5'b10110,
	W = 5'b10111,
	X = 5'b11000,
	Y = 5'b11001,
	Z = 5'b11010,
	DONE = 5'b11111;


always @ (posedge Clk)
begin
	if(RESET)
	begin
		STATE <= INIT;
		STROBE <= 1'b0;
		LETTER <= 5'b00000;
	end
	else
	begin
		case(STATE)
			INIT:
			begin
				STROBE <= 0;
				if(SHORT) STATE<=E;
				if (LONG) STATE <=T;
			end
			A:
			begin
				if(SHORT) STATE<=R;
				if (LONG) STATE <=W;
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			B:
			begin
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			C:
			begin
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			D:
			begin
				if(SHORT) STATE<=B;
				if (LONG) STATE <=X;
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			E:
			begin
				if(SHORT) STATE<=I;
				if (LONG) STATE <=A;
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			F:
			begin
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			G:
			begin
				if(SHORT) STATE<=Z;
				if (LONG) STATE <=Q;
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			H:
			begin
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			I:
			begin
				if(SHORT) STATE<=S;
				if (LONG) STATE <=U;
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			J:
			begin
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			K:
			begin
				if(SHORT) STATE<=C;
				if (LONG) STATE <=Y;
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			L:
			begin
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			M:
			begin
				if(SHORT) STATE<=G;
				if (LONG) STATE <=O;
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			N:
			begin
				if(SHORT) STATE<=D;
				if (LONG) STATE <=K;
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			O:
			begin
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			P:
			begin
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			Q:
			begin
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			R:
			begin
				if(SHORT) STATE<=L;
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			S:
			begin
				if(SHORT) STATE<=H;
				if (LONG) STATE <=V;
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			T:
			begin
				if(SHORT) STATE<=N;
				if (LONG) STATE <=M;
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			U:
			begin
				if(SHORT) STATE<=F;
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			V:
			begin
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			W:
			begin
				if(SHORT) STATE<=P;
				if (LONG) STATE <=J;
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			X:
			begin
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			Y:
			begin
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			Z:
			begin
				if(END_CHAR) STATE<=DONE;
				LETTER <= STATE;
			end
			DONE: STROBE <= 1'b1;
			default: STATE <= XXXXX;
		endcase
	end
end

endmodule
