domains
    list = integer*.

predicates
    del(integer, list, list).
    createSet(list, list).

clauses
    del(El, [El|T], Res) :- del(El, T, Res).

    del(El, [H|T], [H|Res]) :-  del(El, T, Res), !.

    del(_, [], []).

    createSet([H|T], [H|Res]) :- del(H, T, Tmp), createSet(Tmp, Res), !.
    createSet([], []).

goal
    del(3, [1, 2, 3, 2, 3], Res).