domains
	list = integer*.

predicates
	len(list, integer).
	rec_len(list, integer, integer).

	sum(list, integer).
	rec_sum(list, integer, integer).

	sum_odd_pos(list, integer).
	rec_sum_odd_pos(list, integer, integer).

clauses
	len(List, Len) :- rec_len(List, 0, Len).
	rec_len([], Len, Len) :- !.
	rec_len([_|T], CurLen, Len) :- NewLen = CurLen + 1, rec_len(T, NewLen, Len).

	sum(List, Sum) :- rec_sum(List, 0, Sum).
	rec_sum([], Sum, Sum) :- !.
	rec_sum([H|T], CurSum, Sum) :- NewSum = CurSum + H, rec_sum(T, NewSum, Sum).

	sum_odd_pos(List, Sum) :- rec_sum_odd_pos(List, 0, Sum).
	rec_sum_odd_pos([], Sum, Sum) :- !.
	rec_sum_odd_pos([_], Sum, Sum) :- !.
	rec_sum_odd_pos([_|[H|T]], CurSum, Sum) :- NewSum = CurSum + H, rec_sum_odd_pos(T, NewSum, Sum).

goal
	%len([1, 2, 3], Len).
	%sum([1, 2, -1], Sum).

	%sum_odd_pos([-1, 2, 3, 4], Sum).
	%sum_odd_pos([-1, 2, 3, 4, 5], Sum).