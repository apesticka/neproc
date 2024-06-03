
maptree(_, nil).
maptree(P, b(L, V, R)) :-
    call(P, V),
    maptree(P, L),
    maptree(P, R).

subtreeHeight(HDecr, HDecr, HRight) :- between(-1, HDecr, HRight).
subtreeHeight(HDecr, HLeft, HDecr) :- HDecrDecr is HDecr - 1, between(-1, HDecrDecr, HLeft).

subtreeSize(N, NLeft, NRight) :-
    NDecr is N - 1,
    between(0, NDecr, NLeft),
    NRight is NDecr - NLeft.

size(nil, 0, -1).
size(b(nil, _, nil), 1, 0).
size(T, N, H) :-
    H > 0,
    N > 0,

    HDecr is H - 1,
    subtreeHeight(HDecr, HLeft, HRight),
    subtreeSize(N, NLeft, NRight),

    size(Left, NLeft, HLeft),
    size(Right, NRight, HRight),

    T = b(Left, _, Right).
