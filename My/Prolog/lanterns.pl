
flip1(out, lit).
flip1(lit, out).

flip3noLooping([S1, S2, S3|S], [T1, T2, T3|S]) :- flip1(S1, T1), flip1(S2, T2), flip1(S3, T3).
flip3noLooping([S1|S], [S1|T]) :- flip3noLooping(S, T).

splitLast2([X, Y], [], [X, Y]) :- !.
splitLast2([L1|List], [L1|Rest], Last) :- splitLast2(List, Rest, Last).

splitLast([X], [], X) :- !.
splitLast([L1|List], [L1|Rest], Last) :- splitLast(List, Rest, Last).

flip3yesLooping([S1|S], [T1|T]) :-
    same_length(S, T),
    splitLast2(S, SR, [SL1, SL2]),
    splitLast2(T, SR, [TL1, TL2]),
    flip3([S1, SL1, SL2], [T1, TL1, TL2]).
flip3yesLooping([S1, S2|S], [T1, T2|T]) :-
    same_length(S, T),
    splitLast(S, SR, SL),
    splitLast(T, SR, TL),
    flip3([S1, S2, SL], [T1, T2, TL]).

flip3([S1, S2, S3], [T1, T2, T3]) :- flip1(S1, T1), flip1(S2, T2), flip1(S3, T3), !.
flip3(S, T) :- flip3noLooping(S, T).
flip3(S, T) :- flip3yesLooping(S, T).







% Flips N 'bits' starting at Pos
% M is how many are left to flip
% flipPos(S, T, Pos, N, M)
flipNPos(S, S, _, 0, 0) :- !.
flipNPos([], [], _, N, N) :- !.
flipNPos([S1|S], [T1|T], 1, N, M) :- flip1(S1, T1), NewN is N - 1, flipNPos(S, T, 1, NewN, M), !.
flipNPos([S1|S], [S1|T], Pos, N, M) :- Pos > 1, NewPos is Pos - 1, flipNPos(S, T, NewPos, N, M), !.


% Flips lantern at Pos, Pos+1 and Pos+2
% If a position is over the length of the list, loops over to the start
flip3Pos(S, T, Pos) :-
    flipNPos(S, T1, Pos, 3, M),
    flipNPos(T1, T, 1, M, 0).

% Returns a 'bitmask' by flipping 3 lanterns from a base (usually all 0) state
posToBitmask(Base, Pos, Mask) :- flip3Pos(Base, Mask, Pos).

flipWMask(out, A, A).
flipWMask(lit, A, B) :- flip1(A, B).
addMask(Mask, A, O) :- maplist(flipWMask, Mask, A, O).

% P is a list of positions to flip
flipAll(S, T, P) :-
    same_length(S, Base),
    allOut(Base),
    maplist(posToBitmask(Base), P, Masks),
    foldl(addMask, Masks, S, T).

% Holds if the given list has only 'out' lanterns
allOut([]). allOut([out|L]) :- allOut(L).

% State is a set of lanterns (positions) to flip
finalState(Initial, State) :- flipAll(Initial, Final, State), allOut(Final).

% Holds if there exists an action to get from one state to the next
action([], Len, [X]) :- between(1, Len, X).
action([S|State], Len, [X, S|State]) :-
    SIncr is S + 1,
    between(SIncr, Len, X).

bfs([State|_], State, Initial, _) :- finalState(Initial, State).
bfs([State|Queue], Result, Initial, Len) :-
    findall(NewState, action(State, Len, NewState), NewStates),
    append(Queue, NewStates, NewQueue),
    bfs(NewQueue, Result, Initial, Len), !.

reconstructPathHelper(Pos, [A0|A], [NewState, A0|A]) :- flip3Pos(A0, NewState, Pos).
reconstructPath(Initial, Positions, Path) :-
    reverse(Positions, PRes),
    foldl(reconstructPathHelper, PRes, [Initial], PathR),
    reverse(PathR, Path).

pumpkin(Initial, Path) :-
    length(Initial, InitialLen), InitialLen >= 3,
    bfs([[]], Positions, Initial, InitialLen),
    reconstructPath(Initial, Positions, Path).
