muz(jirka).
muz(pavel).
muz(adam).

zena(marie).
zena(adela).
zena(jitka).

rodic(jirka, marie).
rodic(jirka, adam).
rodic(jitka, marie).
rodic(pavel, jirka).

otec(X, Y) :- rodic(X, Y), muz(X).