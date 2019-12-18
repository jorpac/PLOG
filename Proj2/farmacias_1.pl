% Farmacias 1

%farmacia(+Name, +Id, +Volume_Encomenda).
farmacia("Sede", 0, 0).
farmacia("Farm1", 1, 20).
farmacia("Farm2", 2, 20).
farmacia("Farm3", 3, 20).
farmacia("Farm4", 4, 20).
farmacia("Farm5", 5, 20).

%dist(+Id1, +Id2, +Time_Dist).
dist(0, 1, 10).
dist(0, 2, 20).
dist(1, 2, 40).
dist(1, 4, 45).
dist(1, 5, 60).
dist(2, 3, 30).
dist(3, 4, 55).
dist(3, 5, 20).
dist(4, 5, 10).