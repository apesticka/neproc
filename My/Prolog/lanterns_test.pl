

mapToList(Len, _, R) :- length(R, Len).

genMatrix(M, N, O) :-
    length(L, M),
    maplist(mapToList(N), L, O).

mapRow(_, [], _, _) :- !.
mapRow(Pred, [X|Row], M, N) :-
    call(Pred, M, N, X),
    Inc is N + 1,
    mapRow(Pred, Row, M, Inc).
mapMatrix(_, [], _) :- !.
mapMatrix(Pred, [Row|Mat], M) :-
    mapRow(Pred, Row, M, 1),
    Inc is M + 1,
    mapMatrix(Pred, Mat, Inc).

mapMatrix(Pred, Mat) :- mapMatrix(Pred, Mat, 1).

% matrixMaker(Off, M, N, X) :- (X is (M - N + Off + 1) mod 3).
matrixMaker(Off, Size, M, N, X) :- (((M - N) mod Size + Off) mod 3 =:= 0 -> X = 0; X = 1).

% 4 -> 2
% 5 -> 0
% 7 -> 2

generateMatrix(M, Size) :-
    genMatrix(Size, Size, M),
    Off is (Size + 1) mod 3,
    mapMatrix(matrixMaker(Off, Size), M).

dotMult(A, B, C) :- C is A * B.
dotSum(X, A, R) :- R is ((X + A) mod 2).
dot(V1, V2, Result) :-
    maplist(dotMult, V1, V2, Prod),
    foldl(dotSum, Prod, 0, Result).

mult(Matrix, Vector, Result) :-
    maplist(dot(Vector), Matrix, Result).

flip01(0, 1). flip01(1, 0).

solve(Initial, Result) :-
    length(Initial, Len),
    generateMatrix(M, Len),
    % maplist(flip01, Initial, Flipped),
    Flipped = Initial,
    mult(M, Flipped, Result).

printMatrix([]) :- !.
printMatrix([R|M]) :-
    writeln(R),
    printMatrix(M).