v(o, 0).
v(x, 1).

sum(M1, M2, M3, R) :-
    v(M1, V1), v(M2, V2), v(M3, V3),
    R is V1 + V2 + V3.

minyR([], [_, _]).
minyR([P|Pocty], [M1, M2, M3|Miny]) :-
    sum(M1, M2, M3, P),
    minyR(Pocty, [M2, M3|Miny]).

miny(Pocty, Miny) :-
    same_length(Pocty, Miny),
    append(Miny, [o], MinyO),
    OMinyO = [o|MinyO],
    minyR(Pocty, OMinyO).