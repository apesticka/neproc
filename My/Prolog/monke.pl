pos(a).
pos(b).
pos(c).
pos(d).

% action(State, NewState, Action)
action(state(M, B1, B2, Ban), state(P, B1, B2, Ban), go(P)) :- pos(P), pos(M), M \= P.
action(state(M, M, M, Ban), state(M, box2, M, Ban), stack).
action(state(M, box2, M, Ban), state(M, M, M, Ban), unstack).
action(state(M, M, B2, Ban), state(P, P, B2, Ban), push(box1, P)) :- pos(P), M \= P.
action(state(M, B1, M, Ban), state(P, B1, P, Ban), push(box2, P)) :- pos(P), M \= P.
action(state(M, box2, M, Ban), state(box1, box2, M, Ban), climb_on_1).
action(state(M, M, B2, Ban), state(box1, M, B2, Ban), climb_on_1) :- pos(M).
action(state(box1, box2, B2, Ban), state(B2, box2, B2, Ban), climb_off_1).
action(state(box1, B1, B2, Ban), state(B1, B1, B2, Ban), climb_off_1) :- pos(B1).
action(state(box1, box2, d, false), state(box1, box2, d, true), grab).

initialState(state(a, b, c, false)).
finalState(state(_, _, _, true)).

% findAllAvailableActions(State, Actions) :-
%     findall(NewState, action(State, NewState, A), Actions).

solve(S, [], [S]) :- finalState(S).
solve(S, [A|P], [S|States]) :-
    action(S, NS, A),
    solve(NS, P, States),
    \+ member(S, States).

solve(P) :- initialState(S), solve(S, P, _).