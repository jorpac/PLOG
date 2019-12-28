:-use_module(library(clpfd)).
:-use_module(library(lists)).

:-abolish(farmacia/5).
:-abolish(distTime/1).



%farmacia(+Name, +Id, +Volume_Encomenda, +HoraInicio, +HoraFim).
%farmacia("Sede", 0, 0, 10, 22).
%farmacia("Farm1", 1, 10, 10, 22).
%farmacia("Farm2", 2, 40, 10, 22).
%farmacia("Farm3", 3, 25, 10, 22).
%farmacia("Farm4", 4, 15, 10, 22).
%farmacia("Farm5", 5, 5, 10, 22).
%
%%dist(+Id1, +Id2, +Time_Dist).
%
%
%distTime([
%     0, 20, 15, 30, 47, 28,
%    20,  0,  2, 32, 23, 43,
%    15,  2,  0,  3, 35, 26,
%    30, 32,  3,  0, 21, 60,
%    47, 23, 35, 21,  0, 42,
%    28, 43, 26, 60, 42,  0
%]).

diff:-    
    write('Welcome to DIFF optimization program.'), nl,
    write('Select problem dimension:'), nl,
    write(' 1-> Small Problem (5 farmacies)'), nl,
    write(' 2-> Medium Problem(10 farmacies)'), nl,
    write(' 3-> Big Problem(15 farmacies)'), nl,
    read(Dimension),
    write('Enter available vans:'), nl,
    read(NVans),
    Dimension = 1, !, 
    consult('farmacias_1.pl'),
    minDist(NVans,Farmacies, D).

diff:-
    (Dimension = 2 ->
    consult('farmacias_2.pl'), !;
    consult('farmacias_3.pl'), !),
    minDist(NVans,Farmacies, D).



% Cenas a optimizar: nº carrinhas; dist/carrinha

% Minimizar distancia percorrida
minDist(NVans, Farmacies, D) :-
	distTime(BigList),
	getFarmacies(N),
    length(Farmacies, N),
    N1 is N-1,
	domain(Farmacies, 0, N1),
	all_distinct(Farmacies),

	element(1, Farmacies, 0),

	getTotalDist(BigList, Farmacies, D, N),

	labeling([minimize(D)], Farmacies), write(Farmacies), write(' - '), write(D), nl, fail.




%% Funcoes Auxiliares

getTotalDist(_, [_], 30, _).
getTotalDist(Big, [A,B|T], D, N) :-
	I #= A*N + B + 1,
    element(I, Big, D1), 
	getTotalDist(Big, [B|T], D2, N),
    D #= D2 + D1 + 30.


getFarmacies(Int):-
    findall(Per, farmacia(Per, _, _, _, _), P),
    length(P, Int).