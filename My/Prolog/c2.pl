nat(0).
nat(s(N)) :- nat(N).

leq(0, Y) :- nat(Y).
leq(s(X), s(Y)) :- leq(X, Y).

add(0, Y, Y) :- nat(Y).
add(s(X), Y, s(Z)) :- add(X, Y, Z).

mult(0, Y, 0) :- nat(Y). 
mult(s(X), Y, R) :-
    mult(X, Y, R2),
    add(R2, Y, R).

div(X, Y, 0, X) :- leq(X, Y), X \= Y.
% Z / Y = Q, R
% Z = X - Y
div(X, Y, s(Q), R) :-
    Y \= 0,
    leq(Y, X),
    add(Z, Y, X),
    div(Z, Y, Q, R).