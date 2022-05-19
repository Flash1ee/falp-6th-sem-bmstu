% Задачки от Кострицкого
% 1. [1, 2, 3, 4, 5, 6] -> [4, 5, 6, 1, 2, 3]
% 2. [1, 2, 3, 4, 5, 6] -> [2, 1, 4, 3, 6, 5]
domains
  list = integer*
predicates
  reverse(list, list, list).
  
  rec_len(integer, integer, list).
  len(integer, list).
  
  halfsOfList(list, list, list).
  
  task_2(list, list).
  task_1(list, list).
  
  loop(list, list, list, integer, integer, list).
  merge(list, list, list).
clauses
  merge(L1, [H|T], Res) :- merge([H|L1], T, TmpRes), reverse(TmpRes, Res, []).
  merge(L1, [], L1).

  loop([H|T], L1, Acc, I, End, L2) :- I < End, NewI = I + 1, !, loop(T, L1, [H|Acc], NewI, End, L2).
  loop(T, L1, L1, _, _, T).
  
  halfsOflist(List, L1, L2) :-
          len(Len, List), 
          Center = Len div 2,
          loop(List, L1Tmp, [], 0, Center, L2Tmp),
          reverse(L1Tmp, L1, []),
          reverse(L2Tmp, L2, []).

  task_1(List, Res) :- halfsOfList(List, L1, L2), merge(L2, L1, Res).

  task_2([], []).
  task_2([L], [L]).
  task_2([H, H1|T], [H1, H|T2]) :- task_2(T, T2).

  rec_len(Res, Len, [_ | Tail]) :- NewLen = Len + 1, !, rec_len(Res, NewLen, Tail).
  rec_len(Res, Len, []) :- Res = Len.
  len(Res, List) :- rec_len(Res, 0, List).

  reverse([],Z,Z).
  reverse([H|T],Z,Acc) :- reverse(T,Z,[H|Acc]).
goal

  %len(Res, [1, 2, 3, 4, 5, 6]).
  %reverse([1, 2, 3, 4, 5, 6], Res, []).
  %halfsOfList([1, 2, 3, 4, 5, 6], L1, L2).
  
  %task_1([1, 2, 3, 4, 5, 6], Res).
  %task_1([1, 2, 3, 4, 5], Res).
  %task_1([], Res).

  
  task_2([1, 2, 3, 4, 5, 6], Res).
  %task_2([1, 2, 3, 4, 5], Res).
  %task_2([], Res).
