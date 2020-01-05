:-use_module(library(clpfd)).
:-use_module(library(lists)).

:-abolish(farmacia/5).
:-abolish(distTime/1).


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
    write('Insert number of vans to be used:'), nl,
    read(NVans),
    statistics(walltime, [TimeSinceStart | [TimeSinceLastCall]]),
	getFarmacies(NFarm),
	%optMinDist(NVans, _, _).
    (NVans >= NFarm -> minDist(NFarm); (NVans = 1 -> minDist(1); minDist(NVans, NFarm))),
    statistics(walltime, [NewTimeSinceStart | [ExecutionTime]]),
    write('Execution took '), write(ExecutionTime), write(' ms.'), nl.


% Minimizar distancia percorrida
minDist(1) :-
	distTime(BigList),
	getFarmacies(N),
    length(Farmacies, N),
    N1 is N-1,
	domain(Farmacies, 0, N1),
	all_distinct(Farmacies),
	element(1, Farmacies, 0),
	getTotalDist(BigList, Farmacies, D, N),
	labeling([minimize(D)], Farmacies), write(Farmacies), write(' - '), write(D).


getDist(Vans, D, NFR):-
	getFarmacies(N),
    maximum(B, Vans),
    getLists(FullList, [], Vans, 0, B, NFR),
    calc_dist(N, FullList, D), write(D).


calc_dist(_, [], D):- write(D).

calc_dist(N, [A|T], D):-
    distTime(Big),
    getTotalDist(Big, A, D1, N),
    D2 #= D+D1,
    calc_dist(N, T, D2).

getLists(FL, FL, _, N, N, _).
getLists(FullList, TempFullList, Vans, Now, B, NFR):-
    getN(L, [], Vans, 0, Now, NFR),
    append(TempFullList, [L], New_l),
    Now1 #= Now + 1,
    getLists(FullList, New_l, Vans, Now1, B, NFR).
    

getN(List, Templ, V, 0, Now, NFR):-
    append(Templ, [0], TempL),
    getN(List, TempL, V, 1, Now, NFR).
getN(List, List, _, NFR, _, NFR).
getN(List, Templ, Vans, Ind, Now, NFR):-
    element(Ind, Vans, ZZZ),
    (ZZZ#=Now->
    append(Templ, [Ind], TempL),
    Ind1 #= Ind + 1,
    getN(List, TempL, Vans, Ind1, Now, NFR);
    Ind1 #= Ind + 1,
    getN(List, Templ, Vans, Ind1, Now, NFR)).

    
    
minDist(NVans, NFarm) :-
    NFarm = 6,!,
    consult('farmacias_1.pl'),
    NFR is NFarm-1,
    length(Vans, NFR),
    domain(Vans, 1, NVans),
    getDist(Vans, D, NFR),
    labeling([minimize(D)], Vans).






minDist(NVans, NFarm) :-
	NFarm = 11, !,
	distTime(BigList),

	
	
	Ss = [S1, S2, S3, S4, S5, S6, S7, S8, S9, S10],
    Es = [E1, E2, E3, E4, E5, E6, E7, E8, E9, E10],


    List = [M1, M2, M3],
	
    domain(List, 1, NVans),
	element(2, BigList, A),
    element(3, BigList, B),
    element(4, BigList, C),
    element(5, BigList, D),
    element(6, BigList, E),
    element(7, BigList, F),
    element(8, BigList, G),
    element(9, BigList, H),
    element(10, BigList, I),
    element(11, BigList, J),

    AA #= A + A + 30,
    BB #= B + B + 30,
    CC #= C + C + 30,
    DD #= D + D + 30,
    EE #= E + E + 30,
	FF #= F + F + 30,
	GG #= G + G + 30,
	HH #= H + H + 30,
	II #= I + I + 30,
	JJ #= J + J + 30,
    
    Tasks = [
        task(S1, 15, E1, AA, M1),
        task(S2, 15, E2, BB, M2),
        task(S3, 15, E3, CC, M3),
        task(S4, 15, E4, DD, M2),
        task(S5, 15, E5, EE, M2),
		task(S6, 15, E6, FF, M2),
		task(S7, 15, E7, GG, M1),
		task(S8, 15, E8, HH, M3),
		task(S9, 15, E9, II, M3),
		task(S10, 15, E10, JJ, M3)
    ],

	domain(Ss, 0, 30),
    maximum(End, Es),
	End #=< 30,

    Machines=[machine(1, 720), machine(2, 720), machine(3, 720)],
    cumulatives(Tasks, Machines, [bound(upper)]),
    Ss1 = [S11, S12, S13, S14, S15, S16, S17, S18, S19, S20],
    Es1 = [E11, E12, E13, E14, E15, E16, E17, E18, E19, E20],
    
	Tasks1 = [
		task(S11, AA, E11, 15, M1),
		task(S12, BB, E12, 15, M2),
		task(S13, CC, E13, 15, M3),
		task(S14, DD, E14, 15, M2),
		task(S15, EE, E15, 15, M2),
		task(S16, FF, E16, 15, M3),
		task(S17, GG, E17, 15, M3),
		task(S18, HH, E18, 15, M2),
		task(S19, II, E19, 15, M3),
		task(S20, JJ, E20, 15, M3)
	],
	

	domain(Ss1, 0, 720),
    maximum(End1, Es1),
	End1 #=< 720,

    cumulatives(Tasks1, Machines, [bound(upper)]),
    labeling([], List), labeling([minimize(End1)], Ss1),  sum(Es1, #=, PRL), write(End1), write(Ss1), fail.




minDist(NVans) :-
	getFarmacies(NFarm),
	NFarm = 16,
	distTime(BigList),

	List = [L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15],
	domain(List, 1, NVans),

	Ss = [S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15],
    Es = [E1, E2, E3, E4, E5, E6, E7, E8, E9, E10, E11, E12, E13, E14, E15],

	element(2, BigList, A),
    element(3, BigList, B),
    element(4, BigList, C),
    element(5, BigList, D),
    element(6, BigList, E),
    element(7, BigList, F),
    element(8, BigList, G),
    element(9, BigList, H),
    element(10, BigList, I),
    element(11, BigList, J),
    element(12, BigList, K),
    element(13, BigList, L),
    element(14, BigList, M),
    element(15, BigList, P),
    element(16, BigList, O),

    AA #= A + A + 30,
    BB #= B + B + 30,
    CC #= C + C + 30,
    DD #= D + D + 30,
    EE #= E + E + 30,
	FF #= F + F + 30,
	GG #= G + G + 30,
	HH #= H + H + 30,
	II #= I + I + 30,
	JJ #= J + J + 30,
	KK #= K + K + 30,
	LL #= L + L + 30,
	MM #= M + M + 30,
	PP #= P + P + 30,
	OO #= O + O + 30,

	Tasks = [
		task(S1, AA, E1, 1, L1),
		task(S2, BB, E2, 1, L2),
		task(S3, CC, E3, 1, L3),
		task(S4, DD, E4, 1, L4),
		task(S5, EE, E5, 1, L5),
		task(S6, FF, E6, 1, L6),
		task(S7, GG, E7, 1, L7),
		task(S8, HH, E8, 1, L8),
		task(S9, II, E9, 1, L9),
		task(S10, JJ, E10, 1, L10),
		task(S11, KK, E11, 1, L11),
		task(S12, LL, E12, 1, L12),
		task(S13, MM, E13, 1, L13),
		task(S14, PP, E14, 1, L14),
		task(S15, OO, E15, 1, L15)
	],

	getMachines(NVans, 1, [], Machines),
	write(Machines), nl,
	domain(Ss, 0, 720),
    maximum(End, Es),
	End #=< 720,

	labeling([], List),

    cumulatives(Tasks, Machines, [bound(upper)]),
    labeling([], Ss), write(End), write(Ss).





getMachines(NVans, TempVans, TempMac, Machines) :-
	NVans = TempVans,
	append(TempMac, [machine(TempVans, 1)], Machines).
getMachines(NVans, TempVans, TempMac, Machines) :-
	append(TempMac, [machine(TempVans, 1)], TempMac1),
	TempVans1 is TempVans + 1,
	getMachines(NVans, TempVans1, TempMac1, Machines).






%% Funcoes Auxiliares

getTotalDist(_, [_], 0, _).
getTotalDist(Big, [A,B|T], D, N) :-
	I #= A*N + B + 1,
    element(I, Big, D1), 
	getTotalDist(Big, [B|T], D2, N),
    D #= D2 + D1 + 30.

getTotalDist(_, [_], 0, _).
getTotalDist(Big, [A,B|T], D, N) :-
	I #= A*N + B + 1,
    element(I, Big, D1), 
	getTotalDist(Big, [B|T], D2, N),
    D #= D2 + D1 + 30.


getFarmacies(Int):-
    findall(Per, farmacia(Per, _, _, _, _), P),
    length(P, Int).