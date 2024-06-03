osoba(ada).
osoba(bill).
osoba(steve).

reseni(Cis, Prolog, Swift, Linux, Mac, Windows) :-
    (Cis = ada; Cis = bill; Cis = steve),
    (Prolog = ada; Prolog = bill; Prolog = steve),
    (Swift = ada; Swift = bill; Swift = steve),
    (Linux = ada; Linux = bill; Linux = steve),
    (Mac = ada; Mac = bill; Mac = steve),
    (Windows = ada; Windows = bill; Windows = steve),

    Mac \= bill,
    Windows = Cis,
    Linux \= bill,
    Swift = Mac,
    Swift \= ada,

    Cis \= Prolog,
    Prolog \= Swift,
    Swift \= Cis,

    Linux \= Mac,
    Mac \= Windows,
    Windows \= Linux.
    

prolog(Kdo) :- reseni(_, Kdo, _, _, _, _).