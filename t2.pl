:- use_module(library(lists)).

p1(L1,L2) :-
    gen(L1,L2),
    test(L2).

gen([],[]).
gen(L1,[X|L2]) :-
    select(X,L1,L3),
    gen(L3,L2).

test([]).
test([_]).
test([_,_]).
test([X1,X2,X3|Xs]) :-
    (X1 #< X2, X2 #< X3; X1 #> X2, X2 #> X3),
    test(Xs).

:- use_module(library(clpfd)).

p2(L1,L2) :-
    length(L1,N),
    length(L2,N),
    %
    pos(L1,L2,Is),
    all_distinct(Is),
    %
    test(L2),
    labeling([],Is).

pos([],_,[]).
pos([X|Xs],L2,[I|Is]) :-
    element(I,L2,X),
    pos(Xs,L2,Is).


%build(+Budget,+NPacks,+ObjectCosts,+ObjectPacks,-Objects,-UsedPacks)
getBudget([], _, 0).

getBudget([H|T], ObjectCosts, Spent):-
    getBudget(T, ObjectCosts, Spent1),
    element(H, ObjectCosts, Sp1),
    Spent#=Spent1+Sp1.   
getUsedPacks([], _, 0).
getUsedPacks([H|T], ObjectPacks, UsedPacks):-
    getUsedPacks(T, ObjectPacks, UsedPacks1),
    element(H, ObjectPacks, Pack),
    UsedPacks #= UsedPacks1 + Pack.

build(Budget, NPacks, ObjectCosts, ObjectPacks, Objects, UsedPacks):-
    length(ObjectPacks, N),
    length(Objects, 3),
    domain(Objects, 1, N),
    all_distinct(Objects),
    getUsedPacks(Objects, ObjectPacks, UsedPacks),
    UsedPacks #=< NPacks,
    getBudget(Objects, ObjectCosts, Spent),
    Spent #=< Budget,
    labeling([maximize(UsedPacks)], Objects).




%cut(+Shelves,+Boards,-SelectedBoards)

cut(Shelves, Boards, SelectedBoards):-
    length(Shelves, NShelves),
    length(SelectedBoards, NShelves),
    length(Boards, BM),
    domain(SelectedBoards, 1, BM),
    length(Ss, NShelves),
    length(Es, NShelves),
    % Ss = [S1, S2, S3, S4, S5, S6, S7],
    % Es = [E1, E2, E3, E4, E5, E6, E7],
    % element(1, Shelves, A),
    % element(2, Shelves, B),
    % element(3, Shelves, C),
    % element(4, Shelves, D),
    % element(5, Shelves, E),
    % element(6, Shelves, F),
    % element(7, Shelves, G),

    % element(1, SelectedBoards, AA),
    % element(2, SelectedBoards, BB),
    % element(3, SelectedBoards, CC),
    % element(4, SelectedBoards, DD),
    % element(5, SelectedBoards, EE),
    % element(6, SelectedBoards, FF),
    % element(7, SelectedBoards, GG),
    
    % element(1, Boards, M1),
    % element(2, Boards, M2),
    % element(3, Boards, M3),
    % Task = [
    %     task(S1, 1, E1, A, AA),
    %     task(S2, 1, E2, B, BB),
    %     task(S3, 1, E3, C, CC),
    %     task(S4, 1, E4, D, DD),
    %     task(S5, 1, E5, E, EE),
    %     task(S6, 1, E6, F, FF),
    %     task(S7, 1, E7, G, GG)
    % ],
    
    %Machine = [machine(1, M1), machine(2, M2), machine(3, M3)],


    makeTasks(Tasks, [], Ss, Es, Shelves, SelectedBoards),
    makeMachines(M, [], Boards, 1),
    domain(Ss, 1, 7),
    maximum(End, Es),
    cumulatives(Tasks, M, [bound(upper)]),
    labeling([minimize(End)], Ss), labeling([], SelectedBoards).


makeTasks(T, T, [], [], [], []).
makeTasks(Task, TempT,[S|M], [E|N], [H|T], [I|J]):-
    
    append(TempT, [task(S, 1, E, H, I)], T1),
    
    makeTasks(Task, T1, M, N, T, J).


makeMachines(M, M, [], _).
makeMachines(Machine, TempM, [H|T], I):-
    append(TempM, [machine(I, H)], TempM1),
    I1 is I+1,
    makeMachines(Machine, TempM1, T, I1).


pls11(V):-
