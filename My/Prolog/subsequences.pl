sublist(L, M) :- append(M, _, L), M \= [].
sublist([_|L], M) :- sublist(L, M).

subseq([], []).
subseq([X|L], [X|M]) :- subseq(L, M).
subseq([_|L], M) :- subseq(L, M).

disjoint([], [], []).
disjoint([X|L], [X|M], N) :- disjoint(L, M, N).
disjoint([X|L], M, [X|N]) :- disjoint(L, M, N).