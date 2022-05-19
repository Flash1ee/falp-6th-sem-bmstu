predicates
   fib(integer, integer)
   fib(integer, integer, integer, integer)

clauses
   fib(0, 0) :- !.
   fib(1, 1) :- !.
   fib(N, Result) :- fib(N, 0, 1, Result).

   fib(0, N, _, N) :- !.
   fib(N, Prev1, Prev2, Result):- N > 0, New_Prev2 = Prev1 + Prev2, N1 = N - 1, fib(N1, Prev2, New_Prev2, Result).

goal
   fib(9, R).