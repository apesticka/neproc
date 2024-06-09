extractAttributesFromRow([Name-_], [Name]) :- !.
extractAttributesFromRow([Name-_|Row], [Name|Attrib]) :-
    extractAttributesFromRow(Row, Attrib).

extractAttributes([Row], Attrib) :- extractAttributesFromRow(Row, Attrib), !.
extractAttributes([Row|Rows], Attrib) :-
    extractAttributesFromRow(Row, AttribRow),
    extractAttributes(Rows, AttribRest),
    union(AttribRow, AttribRest, Attrib).

tryAddRowToSingleAttrib([Key-Val|_], Key-Vals, Key-[Val|Vals]) :- !.
tryAddRowToSingleAttrib([], Key-Vals, Key-[nedef|Vals]) :- !.
tryAddRowToSingleAttrib([_|Row], Attrib, Res) :- tryAddRowToSingleAttrib(Row, Attrib, Res).

addRow(Row, Attrib, Res) :- maplist(tryAddRowToSingleAttrib(Row), Attrib, Res).

asKey(Name, Name-[]).
sortAttrib(Key-Vals, Key-Sorted) :- sort(Vals, Sorted).

extrakce(Rows, Res) :-
    extractAttributes(Rows, AttributeNames),
    sort(AttributeNames, SortedNames),
    maplist(asKey, SortedNames, Attrib),
    foldl(addRow, Rows, Attrib, UnsortedRes),
    maplist(sortAttrib, UnsortedRes, Res).
