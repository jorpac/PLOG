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
    (Dimension = 1-> 
    consult('farmacias_1.pl');
    (Dimension = 2 ->
    consult('farmacias_2.pl');
    consult('farmacias_3.pl'))),
    write(' 1-> Minimize Vans'), nl,
    write(' 2-> Minimize Distance'), nl,
    read(Option),
    Option = 1, !,
    minDist(1,Farmacies, D).
diff:-
    Option = 2,
    write(' 1-> 1 Van'), nl,
    write(' 3-> 3 Vans'), nl,
    write(' 5-> 5 Vans'), nl,
    read(NVans),
    optMinDist(NVans, Farmacies, D).




mult_dist(NVans, Farmacies, D):-
    getFarmacies(N),
    length(Farmacies, N),
    domain(Farmacies, 0, N),
    
    
    calc_min(Farmacies, D).

calc_min([] , 30).
calc_min([A, B|T], D).

optMinDist(NVans, Farmacies, D):-
    NVans = 1,!,
    minDist(1, Farmacies, D).


optMinDist(NVans, Farmacies, End):-
    NVans = 3,!,
	distTime(BigList),
    % getFarmacies(N),
    % N = 6, !,
    % length(Farmacies, N),
    % domain(Farmacies, 0, N),
    Ss = [S1, S2, S3, S4, S5],
    Es = [E1, E2, E3, E4, E5],
    
    element(2, BigList, A),
    element(3, BigList, B),
    element(4, BigList, C),
    element(5, BigList, D),
    element(6, BigList, E),
    element(9, BigList, F),
    element(10, BigList, G),
    element(11, BigList, H),
    element(12, BigList, I),
    element(16, BigList, J),
    element(17, BigList, K),
    element(18, BigList, L),
    element(23, BigList, M),
    element(24, BigList, O),
    element(30, BigList, P),
    % AA #= A + 30,
    % BB #= B + 30,
    % CC #= C + 30,
    % DD #= D + 30,
    % EE #= E + 30,

    Tasks=[
        task(S1, A, E1, 1, 1),
        %task(S1, B, E1, 1, 1),
        %task(S1, C, E1, 1, 1),
        %task(S1, D, E1, 1, 2),
        %task(S1, E, E1, 1, 1),
        task(S2, F, E2, 1, 1),
        %task(S2, G, E2, 1, 1),
        %task(S2, H, E3, 1, 2),
        %task(S2, I, E4, 1, 2),
        task(S3, J, E3, 1, 1),
        %task(S3, K, E1, 1, 1),
        %task(S3, L, E2, 1, 1),
        %task(S4, M, E3, 1, 1),
        task(S4, O, E4, 1, 1),
        task(S5, P, E5, 1, 1)
    ],
    Machines = [machine(1, 1), machine(2, 1)],
    domain(Ss, 1, 720),
    maximum(End, Es),
    cumulatives(Tasks, Machines, [bound(upper)]),
    labeling([minimize(End)], Ss), write(End), write(Ss).




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