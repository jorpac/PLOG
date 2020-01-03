% Farmacias 1
%use_module(library(lists)).

:-dynamic(farmacia/5).
:-dynamic(distTime/1).
%farmacia(+Name, +Id, +Volume_Encomenda, +HoraInicio, +HoraFim).
farmacia("Sede", 0, 0, 10, 22).
farmacia("Farm1", 1, 10, 10, 22).
farmacia("Farm2", 2, 40, 10, 22).
farmacia("Farm3", 3, 25, 10, 22).
farmacia("Farm4", 4, 15, 10, 22).
farmacia("Farm5", 5, 5, 10, 22).

%dist(+Id1, +Id2, +Time_Dist).


distTime([
     0, 20, 15, 30, 47, 28,
    20,  0,  2, 32, 23, 43,
    15,  2,  0,  3, 35, 26,
    30, 32,  3,  0, 21, 60,
    47, 23, 35, 21,  0, 42,
    28, 43, 26, 60, 42,  0
]).
    
        
%    
%optMinDist(NVans, Farmacies, End):-
%    NVans = 3,!,
%	distTime(BigList),
%    getFarmacies(N),
%    N = 6, !,
%    length(Farmacies, N),
%    domain(Farmacies, 0, N),
%    Ss = [S1, S2, S3, S4, S5],
%    Es = [E1, E2, E3, E4, E5],
%
%   
%
%    Tasks=[
%        task(S1, 20, E1, 1),
%        task(S2, 2, E2, 1),
%        task(S2, 3, E3, 1),
%        task(S3, 21, E4, 1),
%        task(S4, 42, E5, 1)
%    ],
%    domain(Ss, 0, 400),
%    maximum(End, Es),
%    cumulative(Tasks, [limit(1)]),
%    labeling([minimize(End)], Ss).
%
%    
    