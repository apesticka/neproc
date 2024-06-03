rotateByOne([H|T], M) :-
    append(T, [H], M).

nat(0).
nat(s(N)) :- nat(N).

leq(0, Y) :- nat(Y).
leq(s(X), s(Y)) :- leq(X, Y).

less(A, B) :- leq(s(A), B).

len([], 0).
len([_|L], s(C)) :- len(L, C).

rotate(L, L, 0).
rotate(L, M, s(C)) :-
    rotateByOne(L, X),
    rotate(X, M, C).

rotate(L, M) :- len(L, Len), less(C, Len), rotate(L, M, C).