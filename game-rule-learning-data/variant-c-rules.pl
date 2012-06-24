initial_board([[x,x,x],[none,none,none],[o,o,o]],player_x).

legal_move(A,B,C) :- row(D), col(E), owns(A,F), empty(G), forward(A,
	H,D), at(H,E,B,F,I), at(H,E,C,G,J), at(D,E,B,G,K), at(D,
	E,C,F,L), frame_obj(I,K,J,L,B,C).
legal_move(A,B,C) :- row(D), col(E), opponent(A,F), owns(A,G),
	empty(H), forward(F,D,I), owns(F,J), sideways(E,K),
	at(I,K,B,G,L), at(I,K,C,H,M), at(D,E,C,G,N), at(D,E,B,
	J,O), frame_obj(L,O,M,N,B,C).
legal_move(A,B,C) :- row(D), col(E), owns(A,F), empty(G), forward(A,
	H,D), at(H,E,B,G,I), at(H,E,C,F,J), at(D,E,B,F,K), at(D,
	E,C,G,L), frame_obj(J,L,I,K,C,B).

outcome(A,B,C) :- row(D), opponent(A,E), forward(E,D,F), forward(E,
	F,G), owns_outcome(E,C), owns_piece(C,H), at(G,I,B,H,
	J).
outcome(A,B,C) :- opponent(A,D), has_no_move(A,B), owns_outcome(D,
	C).
