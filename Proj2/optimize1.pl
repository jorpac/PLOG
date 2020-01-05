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
	getFarmacies(NFarm),
	(NVans >= NFarm -> minDist(NFarm, NFarm); (NVans = 1 -> minDist(1); minDist(NVans, NFarm))).


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


minDist(NVans, NFarm) :-
	NFarm = 6,!,
    distTime(BigList),
    List = [M1, M2, M3, M4, M5],
	domain(List, 1, NVans),
	element(2, BigList, A),
    element(3, BigList, B),
    element(4, BigList, C),
    element(5, BigList, D),
    element(6, BigList, E),

    AA #= A + A + 30,
    BB #= B + B + 30,
    CC #= C + C + 30,
    DD #= D + D + 30,
    EE #= E + E + 30,

    Ss = [S1, S2, S3, S4, S5],
    Es = [E1, E2, E3, E4, E5],
    Tasks = [
        task(S1, 15, E1, AA, M1),
        task(S2, 15, E2, BB, M2),
        task(S3, 15, E3, CC, M3),
        task(S4, 15, E4, DD, M4),
        task(S5, 15, E5, EE, M5)

    ],

	domain(Ss, 0, 30),
    maximum(End, Es),
	End #=< 30,

    Machines=[machine(1, 720), machine(2, 720), machine(3, 720)],
    cumulatives(Tasks, Machines, [bound(upper)]),
    Ss1 = [S11, S12, S13, S14, S15],
    Es1 = [E11, E12, E13, E14, E15],

    Tasks1 = [
        task(S11, AA, E11, 15, M1),
        task(S12, BB, E12, 15, M2),
        task(S13, CC, E13, 15, M3),
        task(S14, DD, E14, 15, M4),
        task(S15, EE, E15, 15, M5)
    ],


	domain(Ss1, 0, 720),
    maximum(End1, Es1),
	End1 #=< 720,

    %Machines=[machine(1, 720), machine(2, 720), machine(3, 720)],
    cumulatives(Tasks1, Machines, [bound(upper)]),
    labeling([], List), labeling([minimize(End1)], Ss1),  write(End1), write(List), fail.



minDist(NVans, NFarm) :-
	NFarm = 11,!,
    distTime(BigList),
    List = [M1, M2, M3, M4, M5, M6, M7, M8, M9, M10],
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

    Ss = [S1, S2, S3, S4, S5, S6, S7, S8, S9, S10],
	Es = [E1, E2, E3, E4, E5, E6, E7, E8, E9, E10],
    Tasks = [
        task(S1, 15, E1, AA, M1),
        task(S2, 15, E2, BB, M2),
        task(S3, 15, E3, CC, M3),
        task(S4, 15, E4, DD, M4),
        task(S5, 15, E5, EE, M5),
		task(S6, 15, E6, FF, M6),
        task(S7, 15, E7, GG, M7),
        task(S8, 15, E8, HH, M8),
        task(S9, 15, E9, II, M9),
        task(S10, 15, E10, JJ, M10)
    ],

	domain(Ss, 0, 30),
    maximum(End, Es),
	End #=< 30,

    Machines=[machine(1, 720), machine(2, 720), machine(3, 720)],
    cumulatives(Tasks, Machines, [bound(upper)]),
    Ss1 = [S1A, S2B, S3C, S4D, S5E, S6F, S7G, S8H, S9I, S10J],
	Es1 = [E1A, E2B, E3C, E4D, E5E, E6F, E7G, E8H, E9I, E10J],

    Tasks1 = [
        task(S1A, AA, E1A, 15, M1),
        task(S2B, BB, E2B, 15, M2),
        task(S3C, CC, E3C, 15, M3),
        task(S4D, DD, E4D, 15, M4),
        task(S5E, EE, E5E, 15, M5),
		task(S6F, FF, E6F, 15, M6),
        task(S7G, GG, E7G, 15, M7),
        task(S8H, HH, E8H, 15, M8),
        task(S9I, II, E9I, 15, M9),
        task(S10J, JJ, E10J, 15, M10)
    ],


	domain(Ss1, 0, 720),
    maximum(End1, Es1),
	End1 #=< 720,

    cumulatives(Tasks1, Machines, [bound(upper)]),
    labeling([], List), labeling([minimize(End1)], Ss1),  write(End1), write(List), fail.




minDist(NVans, NFarm) :-
	NFarm = 16,!,
    distTime(BigList),
    List = [M1, M2, M3, M4, M5, M6, M7, M8, M9, M10, M11, M12, M13, M14, M15],
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

    Ss = [S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15],
	Es = [E1, E2, E3, E4, E5, E6, E7, E8, E9, E10, E11, E12, E13, E14, E15],
    Tasks = [
        task(S1, 15, E1, AA, M1),
        task(S2, 15, E2, BB, M2),
        task(S3, 15, E3, CC, M3),
        task(S4, 15, E4, DD, M4),
        task(S5, 15, E5, EE, M5),
		task(S6, 15, E6, FF, M6),
        task(S7, 15, E7, GG, M7),
        task(S8, 15, E8, HH, M8),
        task(S9, 15, E9, II, M9),
        task(S10, 15, E10, JJ, M10),
		task(S11, 15, E11, KK, M11),
        task(S12, 15, E12, LL, M12),
        task(S13, 15, E13, MM, M13),
        task(S14, 15, E14, PP, M14),
        task(S15, 15, E15, OO, M15)
    ],

	domain(Ss, 0, 30),
    maximum(End, Es),
	End #=< 30,

    Machines=[machine(1, 720), machine(2, 720), machine(3, 720)],
    cumulatives(Tasks, Machines, [bound(upper)]),
    Ss1 = [S1A, S2B, S3C, S4D, S5E, S6F, S7G, S8H, S9I, S10J, S11K, S12L, S13M, S14O, S15P],
	Es1 = [E1A, E2B, E3C, E4D, E5E, E6F, E7G, E8H, E9I, E10J, E11K, E12L, E13M, E14O, E15P],

    Tasks1 = [
        task(S1A, AA, E1A, 15, M1),
        task(S2B, BB, E2B, 15, M2),
        task(S3C, CC, E3C, 15, M3),
        task(S4D, DD, E4D, 15, M4),
        task(S5E, EE, E5E, 15, M5),
		task(S6F, FF, E6F, 15, M6),
        task(S7G, GG, E7G, 15, M7),
        task(S8H, HH, E8H, 15, M8),
        task(S9I, II, E9I, 15, M9),
        task(S10J, JJ, E10J, 15, M10),
		task(S11K, KK, E11K, 15, M11),
        task(S12L, LL, E12L, 15, M12),
        task(S13M, MM, E13M, 15, M13),
        task(S14O, OO, E14O, 15, M14),
        task(S15P, PP, E15P, 15, M15)
    ],


	domain(Ss1, 0, 720),
    maximum(End1, Es1),
	End1 #=< 720,

    cumulatives(Tasks1, Machines, [bound(upper)]),
    labeling([], List), labeling([minimize(End1)], Ss1),  write(End1), write(List), fail.


%% Funcoes Auxiliares

getMachines(NVans, TempVans, TempMac, Machines) :-
	NVans = TempVans,
	append(TempMac, [machine(TempVans, 720)], Machines).
getMachines(NVans, TempVans, TempMac, Machines) :-
	append(TempMac, [machine(TempVans, 720)], TempMac1),
	TempVans1 is TempVans + 1,
	getMachines(NVans, TempVans1, TempMac1, Machines).




getTotalDist(_, [_], 0, _).
getTotalDist(Big, [A,B|T], D, N) :-
	I #= A*N + B + 1,
    element(I, Big, D1), 
	getTotalDist(Big, [B|T], D2, N),
    D #= D2 + D1 + 30.


getFarmacies(Int):-
    findall(Per, farmacia(Per, _, _, _, _), P),
    length(P, Int).
