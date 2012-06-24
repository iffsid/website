initial_board([[x,x,x],[none,none,none],[o,o,o]],player_x).

legal_move(A,B,C) :- row(D), col(E), owns(A,F), empty(G), forward(A,
	H,D), sideways(E,I), at(H,I,B,F,J), at(H,I,C,G,K), at(D,
	E,B,G,L), at(D,E,C,F,M), frame_obj(J,L,K,M,B,C).
legal_move(A,B,C) :- row(D), col(E), opponent(A,F), owns(A,G),
	empty(H), forward(A,I,D), owns(F,J), sideways(E,K),
	at(D,E,C,G,L), at(I,K,B,G,M), at(I,K,C,H,N), at(D,E,B,
	J,O), frame_obj(L,N,O,M,C,B).

outcome(A,B,C) :- row(D), opponent(A,E), forward(E,D,F), forward(E,
	F,G), owns_outcome(E,C), owns_piece(C,H), at(G,I,B,H,
	J).
outcome(A,B,C) :- opponent(A,D), has_no_move(A,B), owns_outcome(D,
	C).
