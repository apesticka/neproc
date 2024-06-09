
% Tries to put it at 0
tryAllocate0(Size, [FirstAdd-FirstSize|Occupied], Size-0, Res) :-
    Size =< FirstAdd,
    CombinedSize is Size + FirstSize,
    (Size == FirstAdd ->
        Res = [0-CombinedSize|Occupied];
        Res = [0-Size,FirstAdd-FirstSize|Occupied]),
    !.

% Tries to put it between first and second occupied spots
allocateOneNot0(Size, [FirstAdd-FirstSize, SecondAdd-SecondSize|Occupied], Size-Placement, Res) :-
    SpotSize is SecondAdd - FirstAdd - FirstSize,
    (
    Size > SpotSize ->
        allocateOneNot0(Size, [SecondAdd-SecondSize|Occupied], Size-Placement, SubRes),
        Res = [FirstAdd-FirstSize|SubRes]
    ; Size == SpotSize ->
        Placement is FirstAdd + FirstSize,
        CombinedSize is FirstSize + Size + SecondSize,
        Res = [FirstAdd-CombinedSize|Occupied]
    ;
        Placement is FirstAdd + FirstSize,
        CombinedSize is FirstSize + Size,
        Res = [FirstAdd-CombinedSize, SecondAdd-SecondSize|Occupied]
    ), !.

% Puts it after the last occupied spot.
allocateOneNot0(Size, [LastAdd-LastSize], Size-Placement, [LastAdd-CombinedSize]) :-
    Placement is LastAdd + LastSize,
    CombinedSize is LastSize + Size.

allocateOne(Size, Occupied, Placement, Res) :-
    tryAllocate0(Size, Occupied, Placement, Res), !;
    allocateOneNot0(Size, Occupied, Placement, Res).

foldableAllocateOne(Size, Occupied-OtherPlacement, ResOccupied-[ResPlacement|OtherPlacement]) :-
    allocateOne(Size, Occupied, ResPlacement, ResOccupied).

alokace(Alokovat, Obsazeno, Umisteni, NoveObsazeno) :-
    foldl(foldableAllocateOne, Alokovat, Obsazeno-[], NoveObsazeno-UmisteniR),
    reverse(UmisteniR, Umisteni).