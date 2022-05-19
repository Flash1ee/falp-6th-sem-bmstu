% dependencies resolver
% Найти максимальное количество пакетов, которые можно установить после разрешения зависимостей.
use_module(library(pprint)).

package("prettyprinter", "1.7.1", [
  dependOn("base", and([ge("4.7.0"), lt("5.0.0")])),
  dependOn("ghc-prim"),
  if("ghc-prim", lt("8.0.0"), [
    dependOn("fail", and([ge("4.9.0"), lt("4.10.0")])),
    dependOn("semigroups", ge("0.17.0")),
    dependOn("void", and([ge("0.4.0"), lt("0.8.0")]))
  ]),
  dependOn("prettyprinter"),
  dependOn("template-haskell", ge("2.9.0")),
  dependOn("text")
]).

package("ghc-prim", "0.4.0", [
  dependOn("rts", and([ge("1.0.0"), lt("1.1.0")]))
]).

package("fail", "4.9.0", [
  dependOn("base", and([ge("4.3.0"), lt("4.9.0")]))
]).

package("semigroups", "0.20.0", [
  dependOn("base", and([ge("2.0.0"), lt("5.0.0")])),
  dependOn("binary"),
  dependOn("bytestring", and([ge("0.9.0"), lt("1.0.0")])),
  dependOn("bytestring-builder", and([ge("0.10.4"), lt("1.0.0")])),
  dependOn("containers", and([ge("0.3.0"), lt("0.7.0")])),
  dependOn("deepseq", and([ge("1.1.0"), lt("1.5.0")])),
  dependOn("ghc-prim"),
  dependOn("hashable", and([ge("1.2.5"), lt("1.5.0")])),
  dependOn("nats", and([ge("0.1.0"), lt("2.0.0")])),
  dependOn("tagged", and([ge("0.4.4"), lt("1.0.0")])),
  dependOn("template-haskell", and([ge("2.5.0"), lt("2.11.0")])),
  dependOn("text", and([ge("0.10.0"), lt("2.0.0")])),
  dependOn("transformers", and([ge("0.2.0"), lt("0.7.0")])),
  dependOn("transformers-compat", and([ge("0.5.0"), lt("1.0.0")])),
  dependOn("unordered-containers", and([ge("0.2.0"), lt("0.3.0")]))
]).

package("transformers", "0.5.6", [
  dependOn("base", and([ge("2.0.0"), lt("6.0.0")])),
  dependOn("ghc-prim")
]).

package("template-haskell", "2.18.0", [
  dependOn("base", and([ge("4.11.0"), lt("4.17.0")])),
  dependOn("ghc-boot-th", eq("9.2.1")),
  dependOn("ghc-prim"),
  dependOn("pretty", and([ge("1.1.0"), lt("1.2.0")]))
]).

package("template-haskell", "2.11.0", [
  dependOn("base", and([ge("4.7.0"), lt("4.10.0")])),
  dependOn("ghc-boot-th", and([ge("8.0.0"), lt("8.1.0")])),
  dependOn("pretty", and([ge("1.1.0"), lt("1.2.0")]))
]).

package("ghc-boot-th", "8.0.2", [
dependOn("base", and([ge("4.7.0"), lt("4.10.0")]))
]).

package("ghc-boot-th", "8.2.2", [
dependOn("base", and([ge("4.7.0"), lt("4.11.0")]))
]).

package("text", "1.2.4", [
  dependOn("array", and([ge("0.3.0"), lt("0.6.0")])),
  dependOn("base", and([ge("4.3.0"), lt("4.16.0")])),
  dependOn("binary", and([ge("0.5.0"), lt("0.9.0")])),
  dependOn("bytestring", and([ge("0.9.0"), lt("0.12.0")])),
  dependOn("bytestring-builder", and([ge("0.10.4"), lt("0.11.0")])),
  dependOn("deepseq", and([ge("1.1.0"), lt("1.5.0")])),
  dependOn("ghc-prim", and([ge("0.2.0"), lt("0.8.0")])),
  if("ghc-prim", ge("9.0.0"), [
    dependOn("ghc-bignum", and([ge("1.0.0"), lt("1.1.0")]))
  ]),
  if("ghc-prim", lt("9.0.0"), [
    dependOn("integer-gmp", and([ge("0.2.0"), lt("1.1.0")])),
    dependOn("integer-simple", and([ge("0.1.0"), lt("0.5.0")]))
  ]),
  dependOn("template-haskell", and([ge("2.5.0"), lt("2.18.0")]))
]).

package("void", "0.7.3", [
  dependOn("base", and([ge("3.0.0"), lt("10.0.0")])),
  dependOn("deepseq", and([ge("1.1.0"), lt("1.5.0")])),
  dependOn("ghc-prim"),
  dependOn("hashable", ge("1.1.0")),
  dependOn("semigroups", ge("0.8.2")),
  dependOn("template-haskell", and([ge("2.5.0"), lt("2.11.0")]))
]).

package("void", "0.6.1", [
  dependOn("base", and([ge("3.0.0"), lt("4.8.0")])),
  dependOn("ghc-prim"),
  dependOn("hashable", ge("1.1.0")),
  dependOn("semigroups", and([ge("0.8.2"), lt("0.17.0")]))
]).

package("ghc-bignum", "1.2.0", [
  dependOn("ghc-prim", and([ge("0.5.1"), lt("0.9.0")]))
]).

package("rts", "1.0.9", []).

package("binary", "0.8.9", [
  dependOn("array"),
  dependOn("base", and([ge("4.5.0"), lt("5.0.0")])),
  dependOn("bytestring", ge("0.10.4")),
  dependOn("containers"),
  dependOn("ghc-prim")
]).

package("bytestring", "0.10.12", [
  dependOn("base", and([ge("4.2.0"), lt("4.16.0")])),
  dependOn("deepseq"),
  dependOn("ghc-prim"),
  if("ghc-prim", ge("8.11.0"), [
    dependOn("ghc-bignum", ge("1.0.0"))
  ]),
  if("ghc-prim", and([ge("6.11.0"), lt("8.11.0")]), [
    dependOn("integer-gmp", ge("0.2.0"))
  ]),
  if("ghc-prim", and([ge("6.9.0"), lt("6.11.0")]), [
    dependOn("integer", and([ge("0.1.0"), lt("0.2.0")]))
  ])
]).

package("bytestring-builder", "0.10.8", [
  dependOn("base", and([ge("4.2.0"), lt("5.0.0")])),
  dependOn("bytestring", or([and([ge("0.9.0"), lt("0.10.2")]), ge("0.10.4")])),
  dependOn("deepseq")
]).

package("containers", "0.6.5", [
  dependOn("array", ge("0.4.0")),
  dependOn("base", and([ge("4.6.0"), lt("5.0.0")])),
  dependOn("deepseq", and([ge("1.2.0"), lt("1.5.0")]))
]).

package("hashable", "1.3.5", [
  dependOn("base", and([ge("4.5.0"), lt("4.17.0")])),
  dependOn("bytestring", and([ge("0.9.0"), lt("0.12.0")])),
  dependOn("containers", and([ge("0.4.2"), lt("0.7.0")])),
  dependOn("deepseq", and([ge("1.3.0"), lt("1.5.0")])),
  dependOn("ghc-prim"),
  if("ghc-prim", ge("9.0.0"), [
    dependOn("ghc-bignum", and([ge("1.0.0"), lt("1.3.0")]))
  ]),
  if("ghc-prim", lt("9.0.0"), [
    dependOn("integer-gmp", and([ge("0.4.0"), lt("1.1.0")])),
    dependOn("integer-simple")
  ]),
  dependOn("text", and([ge("0.12.0"), lt("1.3.0")]))
]).

package("nats", "1.1.2", [
  dependOn("ghc-prim"),
  if("ghc-prim", lt("8.0.0"), [
    dependOn("base", and([ge("2.0.0"), lt("5.0.0")])),
    dependOn("binary", and([ge("0.2.0"), lt("0.9.0")])),
    dependOn("hashable", and([ge("1.1.2"), lt("1.5.0")])),
    dependOn("template-haskell", and([ge("2.2.0"), lt("2.15.0")]))
  ])
]).

package("tagged", "0.8.6", [
  dependOn("base", and([ge("2.0.0"), lt("5.0.0")])),
  dependOn("ghc-prim"),
  if("ghc-prim", ge("7.6.0"), [
    dependOn("template-haskell", and([ge("2.8.0"), lt("2.19.0")]))
  ]),
  dependOn("transformers", and([ge("0.2.0"), lt("0.7.0")])),
  if("ghc-prim", ge("7.10.0"), [
    dependOn("transformers", and([ge("0.2.0"), lt("0.7.0")]))
  ]),
  if("ghc-prim", lt("7.10.0"), [
    dependOn("transformers-compat", and([ge("0.5.0"), lt("1.0.0")]))
  ]),
  dependOn("deepseq", and([ge("1.1.0"), lt("1.5.0")]))  
]).

package("template-haskell", "2.10.0", [
  dependOn("base", and([ge("4.8.0"), lt("4.9.0")])),
  dependOn("pretty", and([ge("1.1.0"), lt("1.2.0")]))
]).

package("transformers", "0.6.0", [
  dependOn("base", and([ge("2.0.0"), lt("6.0.0")])),
  dependOn("ghc-prim")
]).

package("transformers-compat", "0.7.1", [
  dependOn("base", and([ge("4.3.0"), lt("5.0.0")])),
  dependOn("ghc-prim"),
  if("ghc-prim", lt("8.0.0"), [
    dependOn("fail", and([ge("4.9.0"), lt("4.10.0")]))
  ]),
  dependOn("generic-deriving", and([ge("1.10.0"), lt("2.0.0")])),
  dependOn("mtl", and([ge("2.0.0"), lt("2.2.0")])),
  dependOn("transformers", or([and([ge("0.2.0"), lt("0.4.0")]), and([ge("0.4.1"), lt("0.7.0")])]))
]).

package("unordered-containers", "0.2.19", [
  dependOn("base", and([ge("4.10.0"), lt("5.0.0")])),
  dependOn("deepseq", ge("1.4.3")),
  dependOn("hashable", and([ge("1.2.5"), lt("1.5.0")])),
  dependOn("template-haskell", lt("2.19.0"))
]).

package("unordered-containers", "0.2.14", [
  dependOn("base", and([ge("4.7.0"), lt("5.0.0")])),
  dependOn("deepseq", ge("1.1.0")),
  dependOn("hashable", and([ge("1.0.1"), lt("1.4.0")]))
]).

package("pretty", "1.1.3", [
  dependOn("base", and([ge("4.5.0"), lt("5.0.0")])),
  dependOn("deepseq", ge("1.1.0")),
  dependOn("ghc-prim")
]).

package("array", "0.5.2", [
  dependOn("base", and([ge("4.7.0"), lt("4.13.0")]))
]).

package("deepseq", "1.4.6", [
  dependOn("array", and([ge("0.4.0"), lt("0.6.0")])),
  dependOn("base", and([ge("4.5.0"), lt("4.17.0")])),
  dependOn("ghc-prim")
]).

package("ghc-bignum", "1.0.0", [
  dependOn("ghc-prim", and([ge("0.5.1"), lt("0.8.0")]))
]).

package("integer-gmp", "1.0.3", [
  dependOn("ghc-prim", and([ge("0.6.1"), lt("0.7.0")]))
]).

package("integer-simple", "0.1.1", [
  dependOn("ghc-prim")
]).

package("semigroups", "0.16.2", [
  dependOn("base", and([ge("2.0.0"), lt("4.9.0")])),
  dependOn("bytestring", and([ge("0.9.0"), lt("1.0.0")])),
  dependOn("containers", and([ge("0.3.0"), lt("0.6.0")])),
  dependOn("deepseq", and([ge("1.1.0"), lt("1.5.0")])),
  dependOn("ghc-prim"),
  dependOn("hashable", and([ge("1.1.1"), lt("1.3.0")])),
  dependOn("nats", and([ge("0.1.0"), lt("2.0.0")])),
  dependOn("text", and([ge("0.10.0"), lt("2.0.0")])),
  dependOn("unordered-containers", and([ge("0.2.0"), lt("0.3.0")]))
]).

package("base-orphans", "0.8.6", []).
package("functor-classes-compat", "2.0.9", []).
package("ghc-bignum-orphans", "0.1.9", []).
package("base", "4.8.0", []).
package("generic-deriving", "1.10.0", []).
package("mtl", "2.0.0", []).
package("integer-gmp", "0.5.1", []).
package("containers", "0.3.0", []).

greaterList([], _) :- !.
greaterList([A | TA], [A | TB]) :-
  greaterList(TA, TB).
greaterList([A | _], [B | _]) :-
  A > B.

greaterVersion(A, B) :-
  split_string(A, ".", "", AList),
  split_string(B, ".", "", BList),
  maplist(number_string, AListN, AList),
  maplist(number_string, BListN, BList),
  !, greaterList(AListN, BListN).

acceptedBySelector(_) :- !.

acceptedBySelector(Version, eq(Version)) :- !.

acceptedBySelector(Version, ge(Version)) :- !.

acceptedBySelector(Version, ge(Selector)) :-
  !, greaterVersion(Version, Selector).

acceptedBySelector(Version, le(Version)) :- !.
acceptedBySelector(Version, le(Selector)) :-
  !, not(greaterVersion(Version, Selector)).

acceptedBySelector(Version, lt(Selector)) :-
  !, not(acceptedBySelector(Version, ge(Selector))).

acceptedBySelector(_, or([])) :- !.

acceptedBySelector(Version, or([H | _])) :-
  acceptedBySelector(Version, H).
acceptedBySelector(Version, or([_ | T])) :-
  acceptedBySelector(Version, or(T)).

acceptedBySelector(_, and([])) :- !.

acceptedBySelector(Version, and([H | T])) :-
  !, acceptedBySelector(Version, H),
  !, acceptedBySelector(Version, and(T)).


assertThenRetract(T) :- asserta(T).
assertThenRetract(T) :- retract(T), fail.

:- dynamic(taken/2).

solveDependencies([]) :- !.
solveDependencies([dependOn(Name, Selector) | T]) :-
  taken(Name, TakenVersion),
  !, acceptedBySelector(TakenVersion, Selector),
  !, solveDependencies(T).

solveDependencies([dependOn(Name) | T]) :-
  taken(Name, _),
  !, solveDependencies(T).

solveDependencies([dependOn(Name, Selector) | T]) :-
  not(taken(Name, _)),
  !, package(Name, Version, Dependencies),
  acceptedBySelector(Version, Selector),
  assertThenRetract(taken(Name, Version)),
  solveDependencies(T),
  solveDependencies(Dependencies).

solveDependencies([dependOxn(Name) | T]) :-
  not(taken(Name, _)),
  !, package(Name, Version, Dependencies),
  assertThenRetract(taken(Name, Version)),
  solveDependencies(T),
  solveDependencies(Dependencies).

solveDependencies([if(Name, Selector, D) | T]) :-
  taken(Name, Version),
  acceptedBySelector(Version, Selector),
  !, solveDependencies(D),
  solveDependencies(T).

solveDependencies([if(Name, Selector, _) | T]) :-
  taken(Name, Version),
  not(acceptedBySelector(Version, Selector)),
  !, solveDependencies(T).

solve([]) :- !.

solve([package(N, V, D) | T]) :-
  not(taken(N, _)),
  assertThenRetract(taken(N, V)),
  solveDependencies(D),
  solve(T).

solve([_ | T]) :- solve(T).

solve() :- 
  findall(package(N, P, D), package(N, P, D), All),
  solve(All).

:- dynamic(lastMaxSolve/1).

assertMax(P) :- 
  lastMaxSolve(M),
  length(P, Plen),
  length(M, Mlen),
  Plen > Mlen,
  retract(lastMaxSolve(_)),
  asserta(lastMaxSolve(P)),
  fail.

solveMax() :-
  solve(),
  findall(taken(N, V), taken(N, V), P),
  assertMax(P).
solveMax(_) :- asserta(lastMaxSolve([])), solveMax().
solveMax(M) :- lastMaxSolve(M), retract(lastMaxSolve(_)).

% solveMax(P), print_term(P, []), nl, write("N="), length(P, Plen), write(Plen), nl, nl.
% solveMax(hashable), print_term(hashable, []).
