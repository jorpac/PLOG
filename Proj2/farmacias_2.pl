% Farmacias 2
:-use_module(library(clpfd)).

:-dynamic(farmacia/5).
:-dynamic(distTime/1).
%farmacia(+Name, +Id, +Volume_Encomenda, horainicio, horafim).
farmacia("Sede",  0,  0, 10, 22).
farmacia("Farm1",  1, 10, 10, 22).
farmacia("Farm2",  2, 40, 10, 22).
farmacia("Farm3",  3, 25, 10, 22).
farmacia("Farm4",  4, 15, 10, 22).
farmacia("Farm5",  5,  5, 10, 22).
farmacia("Farm6",  6, 35, 10, 22).
farmacia("Farm7",  7, 20, 10, 22).
farmacia("Farm8",  8, 30, 10, 22).
farmacia("Farm9",  9, 15, 10, 22).
farmacia("Farm10", 10, 20, 10, 22).
%farmacia("Farm20", 20, 18, 10, 22).

%dist(+Id1, +Id2, +Time_Dist).

distTime([
     0, 20, 15, 30, 47, 28, 60, 30, 24, 58, 19,
    20,  0,  2, 32, 23, 43, 40, 46, 55, 51, 39,
    15,  2,  0,  3, 35, 26,  4, 23, 10, 46, 35,
    30, 32,  3,  0, 21, 60, 11, 31,  5, 39, 54,
    47, 23, 35, 21,  0, 42, 55,  1, 22, 17, 29,
    28, 43, 26, 60, 42,  0, 19, 21, 32, 44, 17,
    60, 40,  4, 11, 55, 19,  0,  8, 53, 13, 14,
    30, 46, 23, 31,  1, 21,  8,  0, 28, 32, 37,
    24, 55, 10,  5, 22, 32, 53, 28,  0, 20, 52,
    58, 51, 46, 39, 17, 44, 13, 32, 20,  0, 47,
    19, 39, 35, 54, 29, 17, 14, 37, 52, 47,  0
    ]).
