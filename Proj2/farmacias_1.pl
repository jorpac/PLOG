% Farmacias 1

%farmacia(+Name, +Id, +Volume_Encomenda, +HoraInicio, +HoraFim).
farmacia("Sede", 0, 0, 10, 22).
farmacia("Farm1", 1, 10, 10, 22).
farmacia("Farm2", 2, 40, 10, 22).
farmacia("Farm3", 3, 25, 10, 22).
farmacia("Farm4", 4, 15, 10, 22).
farmacia("Farm5", 5, 5, 10, 22).

%dist(+Id1, +Id2, +Time_Dist).


dist = [
    [ 0, 20, 15, 30, 47, 28],
    [20,  0,  2, 32, 23, 43],
    [15,  2,  0,  3, 35, 26],
    [30, 32,  3,  0, 21, 60],
    [47, 23, 35, 21,  0, 42],
    [28, 43, 26, 60, 42,  0]
].
