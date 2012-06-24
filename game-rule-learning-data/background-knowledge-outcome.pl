:- modeh(*,outcome(+player,+board,-win_outcome))?

:- modeb(*,row(-row))?
:- modeb(*,opponent(+player,-player))?
:- modeb(*,owns(-player,+piece))?
:- modeb(*,forward(+player,+row,-row))?
:- modeb(*,has_move(+player,+board))?
:- modeb(*,has_no_move(+player,+board))?
:- modeb(*,owns_piece(+win_outcome,-piece))?
:- modeb(*,owns_outcome(+player,+win_outcome))?
:- modeb(*,owns_outcome(+player,-win_outcome))?
:- modeb(*,at(+row,+col,+board,+piece))?
:- modeb(*,at(-row,-col,+board,+piece,-obj))?
:- modeb(*,linear_obj(+obj,+obj,+obj))?

:- set(noise,0)?
:- set(c,10)?
:- set(h,5000)?
:- set(n,50)?
:- set(r,4000000)?
:- set(i,50)?
:- set(inflate,1000)?
:- set(nodes,15000)?
:- unset(cover)?

:- set(verbose,3)?

has_move(player_x,B) :- legal_move(player_x,B,_), !.
has_move(player_o,B) :- legal_move(player_o,B,_), !.

has_no_move(A,B) :- not(legal_move(A,B,_)).

at(ROW,COLUMN,BOARD,PIECE) :- row_to_int(ROW,RI),
	col_to_int(COLUMN,CI),
	ref(RI,BOARD,L), ref(CI,L,PIECE).

frame_obj([R1,C1,P1],[R2,C2,P2],[R1,C1,P3],[R2,C2,P4],B1,B2).

prune(_,Body) :-
	setof(row(A),in(row(A),Body),[_,_|_]).
prune(_,Body) :-
	setof(col(A),in(col(A),Body),[_,_|_]).

prune(_,Body) :-
	setof(forward(A,B,C),in(forward(A,B,C),Body),[_,_,_|_]).
prune(_,Body) :-
	setof(opponent(A,B),in(opponent(A,B),Body),[_,_|_]).
prune(_,Body) :-
	setof(owns(A,B),in(owns(A,B),Body),[_,_,_|_]).
prune(_,Body) :-
	setof(has_move(A,B),in(has_move(A,B),Body),[_|_]).
prune(_,Body) :-
	setof(has_no_move(A,B),in(has_no_move(A,B),Body),[_,_|_]).
prune(_,Body) :-
	setof(at(A,B,C,D),in(at(A,B,C,D),Body),[_,_|_]),
	setof(forward(D,E,F),in(forward(D,E,F),Body),[_,_,_|_]).
prune(_,Body) :- setof(forward(G,H,I),in(forward(G,H,I),Body),[_,_,_|_]),
	in(forward(D,E,F),Body), in(forward(A,B,C),Body), not(D==A).
prune(_,Body) :-
	setof(at(A,B,C,D),in(at(A,B,C,D),Body),[_,_|_]),
	setof(at(A,B,C,D,E),in(at(A,B,C,D,E),Body),[_,_|_]).
prune(_,Body) :-
	setof(at(A,B,C,D,E),in(at(A,B,C,D,E),Body),[_,_|_]),
	setof(forward(D,E,F),in(forward(D,E,F),Body),[_,_,_|_]).
prune(_,Body) :-
	setof(forward(G,H,I),in(forward(G,H,I),Body),[_|_]),
	setof(linear(A,B,C,D,E,F),in(linear(A,B,C,D,E,F),Body),[_|_]).
prune(_,Body) :-
	setof(forward(G,H,I),in(forward(G,H,I),Body),[_|_]),
	setof(linear_obj(A,B,C),in(linear_obj(A,B,C),Body),[_|_]).
prune(_,Body) :-
	setof(at(A,B,C,D),in(at(A,B,C,D),Body),[_,_,_,_|_]).
prune(_,Body) :-
	setof(at(A,B,C,D,E),in(at(A,B,C,D,E),Body),[_,_,_,_|_]).
prune(_,Body) :-
	setof(linear(A,B,C,D,E,F),in(linear(A,B,C,D,E,F),Body),[_,_|_]).
prune(_,Body) :-
	setof(linear_obj(A,B,C),in(linear_obj(A,B,C),Body),[_,_|_]).
prune(_,Body) :-  in(linear(A,B,C,D,E,F),Body), A==C.
prune(_,Body) :-  in(linear(A,B,C,D,E,F),Body), A==E.
prune(_,Body) :-  in(linear(A,B,C,D,E,F),Body), C==E.
prune(_,Body) :-  in(linear(A,B,C,D,E,F),Body), B==D.
prune(_,Body) :-  in(linear(A,B,C,D,E,F),Body), B==F.
prune(_,Body) :-  in(linear(A,B,C,D,E,F),Body), D==F.
