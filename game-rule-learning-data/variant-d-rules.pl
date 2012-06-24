initial_board([[x,x,x],[none,none,none],[o,o,o]],player_x).

legal_move(A,B,C) :- row(D), col(E), owns(A,F), empty(G), forward(A,
	H,D), at(H,E,B,F,I), at(H,E,C,G,J), at(D,E,B,G,K), at(D,
	E,C,F,L), frame_obj(I,K,J,L,B,C).
legal_move(A,B,C) :- row(D), col(E), owns(A,F), empty(G), forward(A,
	H,D), at(D,E,B,F,I), at(D,E,C,G,J), at(H,E,B,G,K), at(H,
	E,C,F,L), frame_obj(I,K,J,L,B,C).
legal_move(A,B,C) :- row(D), col(E), opponent(A,F), owns(A,G),
	empty(H), forward(F,D,I), owns(F,J), sideways(E,K),
	at(D,E,C,G,L), at(I,K,B,G,M), at(I,K,C,H,N), at(D,E,B,
	J,O), frame_obj(L,N,O,M,C,B).
legal_move(A,B,C) :- row(D), col(E), owns(A,F), empty(G), sideways(E,
	H), at(D,E,B,F,I), at(D,E,C,G,J), at(D,H,B,G,K), at(D,
	H,C,F,L), frame_obj(I,K,J,L,B,C).

outcome(A,B,C) :- row(D), opponent(A,E), forward(A,D,F), forward(A,
	F,G), owns_outcome(E,C), owns_piece(C,H), at(D,I,B,H,
	J).
outcome(A,B,C) :- opponent(A,D), has_no_move(A,B), owns_outcome(D,
	C).
