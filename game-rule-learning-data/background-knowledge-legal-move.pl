prune(_,Body) :- in(frame(A,B,C,D),Body), C==D.
prune(_,Body) :- in(frame_obj(A,B,C,D),Body), C==D.
prune(_,Body) :- in(frame(A,B,E,F,C,D),Body), C==D.
prune(_,Body) :- in(frame(A,B,C,D,E,F,G,H),Body), G==H.
prune(_,Body) :- in(frame(A,B,C,O,D,E,F,P,G,H),Body), G==H.
prune(_,Body) :- in(frame_obj(A,B,C,D,E,F),Body), E==F.
prune(_,Body) :-
	setof(frame(A,B,C,D),in(frame(A,B,C,D),Body),[_,_|_]).
prune(_,Body) :-
	setof(frame_obj(A,B,C,D),in(frame_obj(A,B,C,D),Body),[_,_|_]).
prune(_,Body) :-
	setof(frame_obj(A,B,C,D,E,F),in(frame_obj(A,B,C,D,E,F),Body),[_,_|_]).
prune(_,Body) :-
	setof(frame(A,B,C,D,E,F),in(frame(A,B,C,D,E,F),Body),[_,_|_]).
prune(_,Body) :-
	setof(frame(A,B,C,D,E,F,G,H),in(frame(A,B,C,D,E,F,G,H),Body),[_,_|_]).
prune(_,Body) :-
	setof(row(A),in(row(A),Body),[_,_|_]).
prune(_,Body) :-
	setof(col(A),in(col(A),Body),[_,_|_]).
prune(_,Body) :-
	setof(forward(A,B,C),in(forward(A,B,C),Body),[_,_|_]).
prune(_,Body) :-
	setof(opponent(A,B),in(opponent(A,B),Body),[_,_|_]).
prune(_,Body) :-
	setof(owns(A,B),in(owns(A,B),Body),[_,_,_|_]).
prune(_,Body) :-
	setof(sideways(A,B),in(sideways(A,B),Body),[_,_|_]).
prune(_,Body) :-
	setof(at(A,B,C,D),in(at(A,B,C,D),Body),[_,_,_,_,_|_]).
prune(_,Body) :-
	setof(at(A,B,C,D,E),in(at(A,B,C,D,E),Body),[_,_,_,_,_|_]).

at(ROW,COLUMN,BOARD,PIECE) :- row_to_int(ROW,RI),
	col_to_int(COLUMN,CI), !,
	ref(RI,BOARD,L), !, ref(CI,L,PIECE).

frame_obj([R1,C1,P1],[R2,C2,P2],[R1,C1,P3],[R2,C2,P4],B1,B2) :-
	frame(R1,C1,B1,B3),
	at(R1,C1,B1,P1),
	at(R2,C2,B1,P2),
	frame(R2,C2,B3,B2),
	at(R1,C1,B2,P3),
	at(R2,C2,B2,P4).

:- modeh(1,legal_move(+player,+board,+board))?

:- modeb(*,row(-row))?
:- modeb(*,col(-col))?
:- modeb(*,opponent(+player,-player))?
:- modeb(*,owns(+player,-piece))?
:- modeb(*,empty(-piece))?
:- modeb(*,at(+row,+col,+board,+piece,-obj))?
:- modeb(*,forward(+player,-row,+row))?
:- modeb(*,forward(+player,+row,-row))?
:- modeb(*,sideways(+col,-col))?
:- modeb(*,frame_obj(+obj,+obj,+obj,+obj,+board,+board))?

:- set(posonly)?
:- set(noise,0)?
:- set(c,15)?
:- set(h,5000)?
:- set(n,50)?
:- set(r,50000)?
:- set(i,50)?
:- set(inflate,10000)?
:- set(nodes,20000)?
