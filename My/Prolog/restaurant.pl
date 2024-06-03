man(david).
man(thomas).
woman(emma).
woman(stella).

solve(Dumplings, Pasta, Soup, Trout, Cider, Beer, Tea, Wine) :-
    (Dumplings = david; Dumplings = emma; Dumplings = stella; Dumplings = thomas),
    (Pasta = david; Pasta = emma; Pasta = stella; Pasta = thomas),
    (Soup = david; Soup = emma; Soup = stella; Soup = thomas),
    (Trout = david; Trout = emma; Trout = stella; Trout = thomas),
    (Cider = david; Cider = emma; Cider = stella; Cider = thomas),
    (Beer = david; Beer = emma; Beer = stella; Beer = thomas),
    (Tea = david; Tea = emma; Tea = stella; Tea = thomas),
    (Wine = david; Wine = emma; Wine = stella; Wine = thomas),

    ((man(Cider), man(Trout)); (woman(Cider), woman(Trout))),
    Dumplings = Beer,
    Soup = Cider,
    ((man(Pasta), man(Beer)); (woman(Pasta), woman(Beer))),
    Tea \= david,
    Wine = emma,
    Dumplings \= stella,

    Dumplings \= Pasta,
    Dumplings \= Soup,
    Dumplings \= Trout,
    Pasta \= Soup,
    Pasta \= Trout,
    Soup \= Trout,

    Cider \= Beer,
    Cider \= Tea,
    Cider \= Wine,
    Beer \= Tea,
    Beer \= Wine,
    Tea \= Wine.

solve(Dumplings, Pasta, Soup, Trout) :- solve(Dumplings, Pasta, Soup, Trout, _, _, _, _).