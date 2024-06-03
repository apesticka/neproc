add(zero, zero, zero, zero).
add(zero, one, one, zero).
add(one, zero, one, zero).
add(one, one, zero, one).

add(X, Y, Z, Out, Carry) :-
    add(X, Y, R, C1),
    add(R, Z, Out, C2),
    add(C1, C2, Carry, _).

add(X3, X2, X1, X0, Y3, Y2, Y1, Y0, Z4, Z3, Z2, Z1, Z0) :-
    add(X0, Y0, Z0, C0),
    add(X1, Y1, C0, Z1, C1),
    add(X2, Y2, C1, Z2, C2),
    add(X3, Y3, C2, Z3, Z4).