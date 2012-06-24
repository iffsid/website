initial_board([[none,none,none],[none,none,none],[none,none,none]],
	player_x).

legal_move(A,B,C) :- row(D), col(E), owns(A,F), empty(G), at(D,
	E,B,G,H), at(D,E,C,F,I), frame_obj(I,I,H,H,C,B).

outcome(A,B,C) :- opponent(A,D), owns_outcome(D,C), owns_piece(C,
	E), at(F,G,B,E,H), at(I,J,B,E,K), at(L,M,B,E,N), linear_obj(K,
	H,N).
