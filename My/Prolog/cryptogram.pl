
rotate_code(Code, Rotation, NewCode) :-
    between(1, 26, Rotation),
    NewCode is (Code + Rotation - 97) mod 26 + 97.

% True if word D decrypts into word D using the keys K1 and K2.

decrypt_codes([], [], _, _).
decrypt_codes([EFirst|ECodes], [DFirst|DCodes], K1, K2) :-
    rotate_code(EFirst, K1, DFirst),
    decrypt_codes(ECodes, DCodes, K2, K1).

decrypt_word(K1, K2, E, D) :-
    string_codes(E, ECodes),
    decrypt_codes(ECodes, DCodes, K1, K2),
    string_codes(D, DCodes).

member_helper(List, Item) :- member(Item, List).
all_present(Dictionary, DWords) :- maplist(member_helper(Dictionary), DWords), !.

% True if words EWords decrypt to DWords (all of which
% are in the dictionary) using the keys K1 and K2.
decrypt_all(EWords, Dictionary, DWords, K1, K2) :-
    maplist(decrypt_word(K1, K2), EWords, DWords),
    all_present(Dictionary, DWords).

decrypt(C, D, M) :-
    split_string(C, " ", " ", EncryptedWords),
    decrypt_all(EncryptedWords, D, DecryptedWords, _, _),
    atomics_to_string(DecryptedWords, " ", M).
