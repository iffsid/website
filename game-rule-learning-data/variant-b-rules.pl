initial_board([[x,x,x],[none,none,none],[o,o,o]],player_x).

legal_move(A,B,C) :- row(D), col(E), owns(A,F), empty(G), forward(A,
	H,D), sideways(E,I), at(H,E,B,F,J), at(H,E,C,G,K), at(D,
	I,B,G,L), at(D,I,C,F,M), frame_obj(J,L,K,M,B,C).
legal_move(A,B,C) :- row(D), col(E), opponent(A,F), owns(A,G),
	empty(H), forward(A,I,D), owns(F,J), sideways(E,K),
	at(D,K,C,G,L), at(I,E,B,G,M), at(I,E,C,H,N), at(D,K,B,
	J,O), frame_obj(L,N,O,M,C,B).
legal_move(A,B,C) :- row(D), col(E), owns(A,F), empty(G), forward(A,
	H,D), sideways(E,I), at(D,I,B,F,J), at(D,I,C,G,K), at(H,
	E,B,G,L), at(H,E,C,F,M), frame_obj(J,L,K,M,B,C).

outcome(A,B,C) :- opponent(A,D), has_no_move(A,B), owns_outcome(D,
	C).
outcome(A,B,C) :- row(D), opponent(A,E), forward(E,D,F), forward(E,
	F,G), owns_outcome(E,C), owns_piece(C,H), at(G,I,B,H,
	J).
