domains
	number = integer

predicates
	maxFromTwo(number, number, number).
	maxFromTwoCut(number, number, number).

	maxFromThree(number, number, number, number).
	maxFromThreeCut(number, number, number, number).

clauses
	maxFromTwo(A, B, A) :- A >= B.
	maxFromTwo(A, B, B) :- A < B.

	maxFromTwoCut(A, B, A) :- A >= B, !.
	maxFromTwoCut(_, B, B).

	maxFromThree(A, B, C, A) :- A >= B, A >= C.
	maxFromThree(_, B, C, Res) :- maxFromTwo(B, C, Res).

	maxFromThreeCut(A, B, C, A) :- A >= B, A >= C, !.
	maxFromThreeCut(_, B, C, Res) :- maxFromTwoCut(B, C, Res).

goal
	%maxFromThree(22, 7, 11, R). %(1)
	maxFromThreeCut(22, 7, 11, R). %(2)