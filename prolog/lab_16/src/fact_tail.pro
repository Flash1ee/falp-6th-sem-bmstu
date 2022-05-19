predicates
    fact(integer, integer)
    fact(integer, integer, integer)
clauses
    fact(0, Result, Result) :- !.
    fact(N, Acc, Result) :- NewN = N - 1, NewAcc = Acc * N, fact(NewN, NewAcc, Result).

    fact(N, Result) :- fact(N, 1, Result).
goal
    fact(9, R).
