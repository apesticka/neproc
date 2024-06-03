
% @<
% Prom. < Cisla < Retezce < Atomy < Sloz. Termy

% Mergesort
split([], [], []).
split([X|Xs], [X|R1], R2) :- split(Xs, R2, R1).

merge(Xs, [], Xs) :- !.
merge([], Ys, Ys) :- !.
merge([X|Xs], [Y|Ys], R) :-
    ( X @=< Y -> merge(Xs, [Y|Ys], S), R = [X|S];
                 merge([X|Xs], Ys, S), R = [Y|S]
    ).

mergesort([], []) :- !.
mergesort([X], [X]) :- !.
mergesort(L, S) :-
    L = [_,_|_],
    split(L, LL, LR),
    mergesort(LL, LS),
    mergesort(LR, RS),
    merge(LS, RS, S).

% SAT

% op(InversPriorita, Typ, Symbol)
% InversPriorita
%   cim mensi, tim vetsi priorita
% Typ
%   fx, fy - prefix
%   xf, yf - postfix
%   xfx, xfy, yfy - infix
%       xfy - doprava asociativni, tj. 1 + (2 + 3)
%       yfx - doleva asociativni, tj. (1 + 2) + 3

:- op(550, xfy, ekv).
:- op(500, xfy, imp).
:- op(450, xfy, or).
:- op(400, xfy, and).
:- op(350, fx, non).

correct_(X) :- atom(X).
correct_(P) :-
    P =.. [Op, L, R],
    member(Op, [ekv, imp, or, and]),
    correct_(L), correct_(R).
correct_(non F) :- correct_(F).

correct(X) :- ground(X), correct_(X).

% vars(a and b or a, R)
%   R = [a, b]

mergeVars(Xs, [], Xs) :- !.
mergeVars([], Ys, Ys) :- !.
mergeVars([X|Xs], [Y|Ys], R) :-
    ( X = Y -> mergeVars(Xs, Ys, S), R = [Y|S];
    ( X @< Y -> mergeVars(Xs, [Y|Ys], S), R = [X|S];
                mergeVars([X|Xs], Ys, S), R = [Y|S])
    ).

vars(X, [X]) :- atom(X), !.
vars(non F, Vars) :- vars(F, Vars), !.
vars(F, Vars) :-
    F =.. [_, L, R],
    vars(L, LVars), vars(R, RVars),
    mergeVars(LVars, RVars, Vars).

genModel([V], [V-false]).
genModel([V], [V-true]).
genModel([Var|Vars], [Var-false|Model]) :- genModel(Vars, Model).
genModel([Var|Vars], [Var-true|Model]) :- genModel(Vars, Model).

% TABLES
andTable(true, true).
orTable(true, false). orTable(false, true). orTable(true, true).
impTable(false, false). impTable(false, true). impTable(true, true).
ekvTable(false, false). ekvTable(true, true).

opTable(and, andTable).
opTable(or, orTable).
opTable(imp, impTable).
opTable(ekv, ekvTable).

useTable(A, B, Model, Res, Table) :-
    eval(A, Model, AV),
    eval(B, Model, BV),
    (call(Table, AV, BV) -> Res = true; Res = false).

% ATOM
eval(A, Model, Res) :-
    atom(A),
    member(A-AV, Model),
    Res = AV, !.

% NON
eval(non A, Model, Res) :-
    eval(A, Model, AV),
    (AV = true -> Res = false; Res = true).

% Binary operators
eval(F, Model, Res) :-
    F =.. [Op, A, B],
    opTable(Op, Table),
    useTable(A, B, Model, Res, Table).

sat(F, Model) :-
    correct(F),
    vars(F, Vars),
    genModel(Vars, Model),
    eval(F, Model, true).

sat(F) :- sat(F, _).