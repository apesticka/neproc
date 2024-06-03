:- use_module(library(clpfd)).
% #=, #=<...

deleteAll(_, [], []).
deleteAll(X, [X|Xs], R) :- !, deleteAll(X, Xs, R).
deleteAll(X, [Y|Xs], [Y|R]) :- deleteAll(X, Xs, R).

max_(A, B, R) :- !, A > B, R = A.
max_(_, B, B).

% once()
% max_(A, B, R) :- (A > B -> R = A; R = B)

double(X, Y) :- Y is X * 2.
% maplist(double, [1, 2, 3, 4], R).

% foldl(plus, [1, 2, 3, 4], 0, R).

incr(R, _, A, B) :- B #= A + 1, B #=< R.
len(L, R) :- foldl(incr(R), L, 0, R).

mapToList(Len, _, R) :- len(R, Len).

% M = 3, N = 2
% O =  [[_, _],
%       [_, _],
%       [_, _]]

genMatrix(M, N, O) :-
    len(L, M),
    maplist(mapToList(N), L, O).

head([H|_], H).
tail([_|L], L).

extractCol(M, C, R) :-
    maplist(head, M, C),
    maplist(tail, M, R).


transpose(M, []) :- maplist(=([]), M), !.
transpose(M, [Col|T]) :-
    extractCol(M, Col, Rest),
    transpose(Rest, T).