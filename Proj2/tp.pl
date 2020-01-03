:-use_module(library(clpfd)).

washing2(Ss, End):-
    Ss = [S1,S2,S3,S4],
    Es = [E1,E2,E3,E4],
    Tasks = [
    task(S1, 4.5, E1, 1, 1),
    task(S2, 7.8, E2, 1, 1),
    task(S3, 3.6, E3, 1, 1),
    task(S4, 2.9, E4, 1, 1),
    task(S1, 4.9, E1, 1, 2),
    task(S2, 7.2, E2, 1, 2),
    task(S3, 4.3, E3, 1, 2),
    task(S4, 3.1, E4, 1, 2)
    ],
    Machines = [machine(1, 1), machine(2, 1)],
    domain(Ss, 1, 30),
    maximum(End, Es),
    cumulatives(Tasks, Machines, [bound(lower)]),
    labeling([minimize(End)], Ss).