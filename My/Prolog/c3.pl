edge(a, b).
edge(b, c).

path(X, X).
path(X, Y) :-
    edge(X, Z),
    path(Z, Y).

len([], 0).
len([_|T], R) :- len(T, TL), R is TL + 1.

% sublist(L, S) :-
%     append(_, S, X),
%     append(X, _, L).

% comb(N, List, Result).
% comb(N, List, Result) :-
%     len(Result, N),
%     sublist(List, Result).

comb(0, _, []).
comb(N2, List, Result) :-
    N2 > 0,
    N is N2 - 1,
    append(_, [Y|Z], List),
    % select(Y, List, Z),
    comb(N, Z, X),
    Result = [Y|X].
