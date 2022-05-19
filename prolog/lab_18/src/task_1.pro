domains
	list = integer*.

predicates
	f(list, integer, list).

clauses
	f([H|T], El, [H|Res]) :- H > El, !, f(T, El, Res).

	f([_|T], El, Res) :- f(T, El, Res).
	f([], _, []) :- !.

goal
	f([6, 0, 4, 2], 3, R).