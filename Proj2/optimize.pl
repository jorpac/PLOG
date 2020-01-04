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
	%optMinDist(NVans, _, _).
	(NVans >= NFarm -> minDist(NFarm); (NVans = 1 -> minDist(1); minDist(NVans))).


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


minDist(NVans) :-
	getFarmacies(NFarm),
	NFarm = 6,
	distTime(BigList),

	List = [L1, L2, L3, L4, L5],
	domain(List, 1, NVans),

	Ss = [S1, S2, S3, S4, S5],
	Es = [E1, E2, E3, E4, E5],
    
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

	Tasks = [
		task(S1, AA, E1, 1, L1),
		task(S2, BB, E2, 1, L2),
		task(S3, CC, E3, 1, L3),
		task(S4, DD, E4, 1, L4),
		task(S5, EE, E5, 1, L5)
	],
	
	getMachines(NVans, 1, [], Machines),

	domain(Ss, 0, 720),
    maximum(End, Es),
	End #=< 720,

	

	cumulatives(Tasks, Machines, [bound(upper)]),
	labeling([ff], List),
    labeling([minimize(End)], Ss), write(End), write(Ss), write(List), fail.





minDist(NVans) :-
	getFarmacies(NFarm),
	NFarm = 11,
	distTime(BigList),

	List = [L1, L2, L3, L4, L5, L6, L7, L8, L9, L10],
	domain(List, 1, NVans),

	Ss = [S1, S2, S3, S4, S5, S6, S7, S8, S9, S10],
    Es = [E1, E2, E3, E4, E5, E6, E7, E8, E9, E10],

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
		task(S1, AA, E1, 1, L1),
		task(S2, BB, E2, 1, L2),
		task(S3, CC, E3, 1, L3),
		task(S4, DD, E4, 1, L4),
		task(S5, EE, E5, 1, L5),
		task(S6, FF, E6, 1, L6),
		task(S7, GG, E7, 1, L7),
		task(S8, HH, E8, 1, L8),
		task(S9, II, E9, 1, L9),
		task(S10, JJ, E10, 1, L10)
	],
	
	getMachines(NVans, 1, [], Machines),

	domain(Ss, 0, 720),
    maximum(End, Es),
	End #=< 720,

	cumulatives(Tasks, Machines, [bound(upper)]),
	labeling([], List),
    labeling([], Ss), write(End), write(Ss).




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

getTotalDist(_, [_], 30, _).
getTotalDist(Big, [A,B|T], D, N) :-
	I #= A*N + B + 1,
    element(I, Big, D1), 
	getTotalDist(Big, [B|T], D2, N),
    D #= D2 + D1 + 30.


getFarmacies(Int):-
    findall(Per, farmacia(Per, _, _, _, _), P),
    length(P, Int).