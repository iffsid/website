inc(X,Y) :- Y is X + 1.

dec(X,Y) :- Y is X - 1.

player(player_x).
player(player_o).

opponent(player_x,player_o).
opponent(player_o,player_x).

piece(x).
piece(o).
piece(none).

empty(none).

owns(player_x,x).
owns(player_o,o).

win_outcome(x_wins).
win_outcome(o_wins).

owns_outcome(player_x,x_wins).
owns_outcome(player_o,o_wins).

owns_piece(x_wins,x).
owns_piece(o_wins,o).

row(r0).
row(r1).
row(r2).

col(c0).
col(c1).
col(c2).

row_to_int(r0,0).
row_to_int(r1,1).
row_to_int(r2,2).

col_to_int(c0,0).
col_to_int(c1,1).
col_to_int(c2,2).

board([[A,B,C],[D,E,F],[G,H,I]]) :-
	piece(A), piece(B), piece(C),
	piece(D), piece(E), piece(F),
	piece(G), piece(H), piece(I).

ref(0,[H|_],H).
ref(0,_,_) :- !, fail.
ref(1,[_,B,_],B).
ref(1,_,_) :- !, fail.
ref(2,[_,_,C],C).
ref(2,_,_) :- !, fail.
ref(I,[H|T],H2) :- dec(I,J), ref(J,T,H2).

%% at/4 is in both the legal-move-generator and outcome backgrounds as
%% it is different for each

at(ROW,COLUMN,BOARD,PIECE,[ROW,COLUMN,PIECE]) :- at(ROW,COLUMN,BOARD,PIECE).

replace(0,A,[_|T],[A|T]) :- !.
replace(0,_,_,_) :- !, fail.
replace(1,A,[X,_|T],[X,A|T]) :- !.
replace(1,_,_,_) :- !, fail.
replace(2,A,[X,Y,_|T],[X,Y,A|T]) :- !.
replace(2,_,_,_) :- !, fail.
replace(I,H1,[H2|T1],[H2|T2]) :- dec(I,J), replace(J,H1,T1,T2).

frame(RROW,CCOLUMN,BOARD1,BOARD2) :-
	row(RROW),
	col(CCOLUMN),
	row_to_int(RROW,ROW),
	col_to_int(CCOLUMN,COLUMN),
	ref(ROW,BOARD1,L1),
	replace(ROW,L2,BOARD1,BOARD3),
	replace(COLUMN,ignore,L1,L2),
	ref(ROW,BOARD2,L3),
	replace(ROW,L4,BOARD2,BOARD3),
	replace(COLUMN,ignore,L3,L4), !,
	board(BOARD2).

%% frame_obj/6 is in both the legal-move-generator and outcome backgrounds as
%% it is different for each

forward(player_x,R1,R2) :- row_to_int(R1,RI1), inc(RI1,RI2), row_to_int(R2,RI2).
forward(player_o,R1,R2) :- row_to_int(R1,RI1), dec(RI1,RI2), row_to_int(R2,RI2).

sideways(C1,C2) :- col_to_int(C1,CI1), inc(CI1,CI2), col_to_int(C2,CI2).
sideways(C1,C2) :- col_to_int(C1,CI1), dec(CI1,CI2), col_to_int(C2,CI2).

linear_test(X1,Y1,X2,Y2,X3,Y3,S) :-
	S is X1*(Y2-Y3)+X2*(Y3-Y1)+X3*(Y1-Y2).
linear(R1,C1,R2,C2,R3,C3) :-
	[R1,C1] \= [R2,C2],
	[R3,C3] \= [R2,C2],
	[R1,C1] \= [R3,C3],
	row_to_int(R1,RI1),
	row_to_int(R2,RI2),
	row_to_int(R3,RI3),
	col_to_int(C1,CI1),
	col_to_int(C2,CI2),
	col_to_int(C3,CI3),
	linear_test(RI1,CI1,RI2,CI2,RI3,CI3,0).
linear_obj([R1,C1,_],[R2,C2,_],[R3,C3,_]) :- linear(R1,C1,R2,C2,R3,C3).

%% obj is included here because it is used as a type by progol, progol
%% must have the ability to generate predicates of this type

obj([A,B,C]) :- row(A), col(B), piece(C).
