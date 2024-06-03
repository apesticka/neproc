nekde(Osoba, pratele(O1, O2, O3)) :-
    Osoba = O1; Osoba = O2; Osoba = O3.

reseni(R) :-
    R = pratele(osoba(ada, _, _), osoba(bill, _, _), osoba(steve, _, _)),
    nekde(osoba(Mac, _, mac), R), Mac \= bill,
    nekde(osoba(_, cs, win), R),
    nekde(osoba(Linux, _, linux), R), Linux \= bill,
    nekde(osoba(Swift, swift, mac), R), Swift \= ada,
    nekde(osoba(_, prolog, _), R).