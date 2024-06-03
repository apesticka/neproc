:- use_module(library(clpfd)).

table([
    1000 - [m],
    900 - [c, m],
    500 - [d],
    400 - [c, d],
    100 - [c],
    90 - [x, c],
    50 - [l],
    40 - [x, l],
    10 - [x],
    9 - [i, x],
    5 - [v],
    4 - [i, v],
    1 - [i]
]).

roman(N, R) :- table(T), member(N-R, T), !.
roman(N, R) :-
    table(T),
    member(Max-MaxR, T),
    Max #=< N,
    N #< 4000,
    append(MaxR, L, R),
    Less #= N - Max,
    roman(Less, L), !.