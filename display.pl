:-use_module(library(lists)).
# :- consult('D:/Users/Joao/Desktop/Curso/PLOG/Projeto_1/player.pl').
   :- use_module(library(random)).
symbol(blank, X):- X = ' '.
symbol(black, X):- X = 'B'.
symbol(white, X):- X = 'W'.
symbol(uncut, X):- X = '.'.
symbol(wcut, X):- X = '^'.
symbol(bcut, X):- X = '~'.
symbol(corner, X) :- X = ' '.

/* Functions responsible for display of board */

initialBoard([
    [corner,wcut,wcut,wcut,wcut,wcut,wcut,wcut,corner],
    [blank,blank,blank,blank,blank,blank,blank,blank],
    [bcut,uncut,uncut,uncut,uncut,uncut,uncut,uncut,bcut],
    [blank,blank,blank,blank,blank,blank,blank,blank],
    [bcut,uncut,uncut,uncut,uncut,uncut,uncut,uncut,bcut],
    [blank,blank,blank,blank,blank,blank,blank,blank],
    [bcut,uncut,uncut,uncut,uncut,uncut,uncut,uncut,bcut],
    [blank,blank,blank,blank,blank,blank,blank,blank],
    [bcut,uncut,uncut,uncut,uncut,uncut,uncut,uncut,bcut],
    [blank,blank,blank,blank,blank,blank,blank,blank],
    [bcut,uncut,uncut,uncut,uncut,uncut,uncut,uncut,bcut],
    [blank,blank,blank,blank,blank,blank,blank,blank],
    [bcut,uncut,uncut,uncut,uncut,uncut,uncut,uncut,bcut],
    [blank,blank,blank,blank,blank,blank,blank,blank],
    [bcut,uncut,uncut,uncut,uncut,uncut,uncut,uncut,bcut],
    [blank,blank,blank,blank,blank,blank,blank,blank],
    [corner,wcut,wcut,wcut,wcut,wcut,wcut,wcut,corner]
    ]).

	midBoard([
    [corner,wcut,wcut,wcut,wcut,wcut,wcut,wcut,corner],
    [blank,black,black,black,black,black,black,black],
    [bcut,uncut,uncut,uncut,uncut,uncut,uncut,uncut,bcut],
    [blank,blank,blank,blank,white,blank,blank,blank],
    [bcut,uncut,uncut,uncut,uncut,uncut,uncut,uncut,bcut],
    [blank,blank,blank,blank,white,blank,blank,blank],
    [bcut,uncut,uncut,uncut,uncut,uncut,uncut,uncut,bcut],
    [blank,blank,blank,blank,white,blank,blank,blank],
    [bcut,uncut,uncut,uncut,uncut,uncut,uncut,uncut,bcut],
    [blank,blank,blank,blank,white,blank,blank,blank],
    [bcut,uncut,uncut,uncut,uncut,uncut,uncut,uncut,bcut],
    [black,black,black,black,black,black,black,blank],
    [bcut,uncut,uncut,uncut,uncut,uncut,uncut,uncut,bcut],
    [blank,blank,blank,blank,blank,white,white,blank],
    [bcut,uncut,uncut,uncut,uncut,uncut,uncut,wcut,bcut],
    [blank,blank,blank,blank,blank,blank,blank,white],
    [corner,wcut,wcut,wcut,wcut,wcut,wcut,wcut,corner]
    ]).

displayboard([],Y,Z).
displayboard([H | T], Y, Z):-
	I is Y+1,
	M is Z+1,
	(Y mod 2 =:= 0 ->
    write('  '),
    displayLine(H, Y),
    nl,
    displayboard(T, I, Z);
	write(M),
    write('| |'),
    displayLine(H, Y),
    nl,
    displayboard(T, I, M)).


displayCell(H):-
    symbol(H, X),
    write(X).


displayLine([],Y).
displayLine([H | T], Y):-
    displayCell(H),
	(Y mod 2 =:= 0 ->
    write('   ');
	write('| |')),
    displayLine(T, Y).

writeBoard(L) :- write(' | |1| |2| |3| |4| |5| |6| |7| |8| |\n'), displayboard(L, 0, 0).

/* */


startBoard :- 
	initialBoard(T), writeBoard(T).
	




playGame :- 
	midBoard(Board),

	write(' -------------------------'),nl,!,
	write('|     SQUEX BOARD GAME    |'),nl, !,
	write(' -------------------------'),nl, nl, nl, !,
	write('Please insert game mode:'), nl, !,
	write('0-> Player vs Player'), nl, !,
	write('1-> Player vs Computer'), nl, !,
	write('2-> Computer vs Player'), nl, !,
	write('3-> Computer vs Computer'), nl, !,
	write('99-> Exit'), nl, !,
	read(Mode),
	(Mode is 0->
	writeBoard(Board),
	playWhite(Board, 0, 0);
	(Mode is 1->
	writeBoard(Board),
	playWhite(Board, 0, 1);
	(Mode is 2->
	writeBoard(Board),
	playWhite(Board, 0, 2);
	(Mode is 3->
	writeBoard(Board),
	playWhite(Board, 0, 3);
	(Mode is 99->
	fail);
	write('Incorrect option'), nl, !, playGame)))).

playWhite(T, GotCut, Computer) :-
	write('White Player Turn ...'), nl, !,
	(Computer is 1 -> 
		random(1, 9, R1),
		random(1, 9, C1);
	(Computer is 3 -> 
		random(1, 9, R1),
		random(1, 9, C1);
	write('Row = '), read(R1), 
	write('Column = '), read(C1))),
	TempR1 is R1*2,
	(isCellEmpty(T,TempR1,C1)->
		replaceBoardCell(T,TempR1,C1,white,Result1),
		checkSquare(Result1, TempR1, C1, white, Result2, Cut),
		write('Cut = '), write(Cut), nl,
		writeBoard(Result2),
		(checkWhiteVictory(Result2, 2)->
			write('White wins!!'), fail; write('ok')),
		(Cut = 0 -> (GotCut = 1 ->
				write('White Player Turn ...'), nl, !,
				(Computer is 1 -> 
					random(1, 9, R2),
					random(1, 9, C2);
					(Computer is 3 -> 
					random(1, 9, R2),
					random(1, 9, C2);
					write('Row = '), read(R2), 
					write('Column = '), read(C2))),
				TempR2 is R2*2,
				isCellEmpty(Result2,TempR2,C2),
				replaceBoardCell(Result2,TempR2,C2,white,Result3),
				checkSquare(Result3, TempR2, C2, white, Result4, Cut),
				write('Cut = '), write(Cut), nl,
				writeBoard(Result4),
				playBlack(Result4, Cut, Computer);

				playBlack(Result2, Cut, Computer)
			);
		playBlack(Result2, Cut, Computer));
		write('Cell is not empty. Try again w/ empty cell'), nl,
		writeBoard(T),
		playWhite(T, GotCut, Computer)).
	
playBlack(T, GotCut, Computer) :-
	write('Black Player Turn ...'), nl, !,
	(Computer is 2 -> 
	random(1, 9, R1),
	random(1, 9, C1);
	(Computer is 3 -> 
		random(1, 9, R1),
		random(1, 9, C1);
	write('Row = '), read(R1), 
	write('Column = '), read(C1))),
	TempR1 is R1*2,
	(isCellEmpty(T,TempR1,C1)->
		replaceBoardCell(T,TempR1,C1,black,Result1),
		checkSquare(Result1, TempR1, C1, black, Result2, Cut),
		write('Cut = '), write(Cut), nl,
		writeBoard(Result2),
		(checkBlackVictory(Result2, 2)->
		write('Black wins!!'), fail; 
		(checkBlackVictory(Result2, 4)->
		write('Black wins!!'), fail; 
		(checkBlackVictory(Result2, 6)->
		write('Black wins!!'), fail; 
		(checkBlackVictory(Result2, 8)->
		write('Black wins!!'), fail; 
		(checkBlackVictory(Result2, 10)->
		write('Black wins!!'), fail; 
		(checkBlackVictory(Result2, 12)->
		write('Black wins!!'), fail; 
		(checkBlackVictory(Result2, 14)->
		write('Black wins!!'), fail; 
		(checkBlackVictory(Result2, 16)->
		write('Black wins!!'), fail; 
		write('ok'))))))))),
		(Cut = 0 -> (GotCut = 1 ->
					write('Black Player Turn ...'), nl, !,
					(Computer is 2 -> 
					random(1, 9, R2),
					random(1, 9, C2);
					(Computer is 3 -> 
					random(1, 9, R2),
					random(1, 9, C2);
					write('Row = '), read(R2), 
					write('Column = '), read(C2))),
					TempR2 is R2*2,
					isCellEmpty(Result2,TempR2,C2),
					replaceBoardCell(Result2,TempR2,C2,black,Result3),
					checkSquare(Result3, TempR2, C2, black, Result4, Cut),
					write('Cut = '), write(Cut), nl,
					writeBoard(Result4),
					playWhite(Result4, Cut, Computer);

					playWhite(Result2, Cut, Computer)
			);
			playWhite(Result2, Cut, Computer));
		write('Cell is not empty. Try again w/ empty cell'), nl,
		writeBoard(T),
		playBlack(T, GotCut, Computer)).



% checks if position is empty %

isCellEmpty(T, R, C) :- 
	nth1(R, T, X),
	nth1(C, X, Y),
	Y = blank.



% checks for cuts %

checkCut(Board, Cut, Piece, R, C) :-
	nth1(R, Board, Y),
	nth1(C, Y, X),
	(Piece = white -> 
		(X = bcut -> Cut is 1; Cut is 0);
		(X = wcut -> Cut is 1; Cut is 0)).

% places squares %

% Top-Left Corner
checkSquare(Board, 2, 1, X, Result, Cut) :-
	nth1(4, Board, C),
	nth1(2, C, Y),

	

	(Y = X ->
		checkCut(Board,G, X, 3, 2),
		(X = white -> replaceBoardCell(Board,3,2,wcut,Result);
						replaceBoardCell(Board,3,2,bcut,Result));
		G is 0, replaceBoardCell(Board,1,1,blank,Result)),

	Cut is G.


% Top-Right Corner
checkSquare(Board, 2, 8, X, Result, Cut) :-
	nth1(4, Board, C),
	nth1(7, C, Y),


	(Y = X ->
		checkCut(Board,G, X, 3, 8),
		(X = white -> replaceBoardCell(Board,3,8,wcut,Result);
						replaceBoardCell(Board,3,8,bcut,Result));
		G is 0, replaceBoardCell(Board,1,1,blank,Result)),

	Cut is G.


% Bottom-Left Corner
checkSquare(Board, 16, 1, X, Result, Cut) :-
	nth1(14, Board, C),
	nth1(2, C, Y),


	(Y = X ->
		checkCut(Board,G, X, 15, 2),
		(X = white -> replaceBoardCell(Board,15,2,wcut,Result);
						replaceBoardCell(Board,15,2,bcut,Result));
		G is 0, replaceBoardCell(Board,1,1,blank,Result)),
		
	Cut is G.


% Bottom-Right Corner
checkSquare(Board, 16, 8, X, Result, Cut) :-
	nth1(14, Board, C),
	nth1(7, C, Y),


	(Y = X ->
		checkCut(Board,G, X, 15, 8),
		(X = white -> replaceBoardCell(Board,15,8,wcut,Result);
						replaceBoardCell(Board,15,8,bcut,Result));
		G is 0, replaceBoardCell(Board,1,1,blank,Result)),
		
	Cut is G.



% 1st Column
checkSquare(Board, R, 1, X, Result, Cut) :-
	Temp1 is R-2,
	nth1(Temp1, Board, V),
	nth1(2, V, Y),
	Temp2 is R-1,



	(Y = X -> 
		checkCut(Board, G, X, Temp2, 2),
		(X = white -> replaceBoardCell(Board,Temp2,2,wcut,T);
						replaceBoardCell(Board,Temp2,2,bcut,T));
		G is 0, replaceBoardCell(Board,1,1,blank,T)),
	

	Temp3 is R+2,
	nth1(Temp3, T, A),
	nth1(2, A, Z),
	Temp4 is R+1,



	(Z = X -> 
		checkCut(Board, H, X, Temp4, 2),
		(X = white -> replaceBoardCell(T,Temp4,2,wcut,Result);
						replaceBoardCell(T,Temp4,2,bcut,Result));
		H is 0, replaceBoardCell(T,1,1,blank,Result)),
		
	(G = 1 -> Cut is 1; (H = 1 -> Cut is 1; Cut is 0)).


% 8th Column
checkSquare(Board, R, 8, X, Result, Cut) :-
	Temp1 is R-2,
	nth1(Temp1, Board, V),
	nth1(7, V, Y),
	Temp2 is R-1,



	(Y = X -> 
		checkCut(Board, G, X, Temp2, 8),
		(X = white -> replaceBoardCell(Board,Temp2,8,wcut,T);
						replaceBoardCell(Board,Temp2,8,bcut,T));
		G is 0, replaceBoardCell(Board,1,1,blank,T)),
	

	Temp3 is R+2,
	nth1(Temp3, T, A),
	nth1(7, A, Z),
	Temp4 is R+1,



	(Z = X -> 
		checkCut(Board, H, X, Temp4, 8),
		(X = white -> replaceBoardCell(T,Temp4,8,wcut,Result);
						replaceBoardCell(T,Temp4,8,bcut,Result));
		H is 0, replaceBoardCell(T,1,1,blank,Result)),
		
	(G = 1 -> Cut is 1; (H = 1 -> Cut is 1; Cut is 0)).


% 1st Row
checkSquare(Board, 2, C, X, Result, Cut) :-
	Temp1 is C+1,
	Temp2 is C-1,

	nth1(4, Board, V),
	nth1(Temp1, V, Y),
	nth1(Temp2, V, Z),


	
	(Y = X -> 
		checkCut(Board, G, X, 3, Temp1),
		(X = white -> replaceBoardCell(Board,3,Temp1,wcut,T);
						replaceBoardCell(Board,3,Temp1,bcut,T));
		G is 0, replaceBoardCell(Board,1,1,blank,T)),



	(Z = X -> 
		checkCut(Board, H, X, 3, C),
		(X = white -> replaceBoardCell(T,3,C,wcut,Result);
						replaceBoardCell(T,3,C,bcut,Result));
		H is 0, replaceBoardCell(T,1,1,blank,Result)),
		
	(G = 1 -> Cut is 1; (H = 1 -> Cut is 1; Cut is 0)).
		

% 8th Row
checkSquare(Board, 16, C, X, Result, Cut) :-
	Temp1 is C+1,
	Temp2 is C-1,

	nth1(14, Board, V),
	nth1(Temp1, V, Y),
	nth1(Temp2, V, Z),


	
	(Y = X -> 
		checkCut(Board, G, X, 15, Temp1),
		(X = white -> replaceBoardCell(Board,15,Temp1,wcut,T);
						replaceBoardCell(Board,15,Temp1,bcut,T));
		G is 0, replaceBoardCell(Board,1,1,blank,T)),



	(Z = X -> 
		checkCut(Board, H, X, 15, C),
		(X = white -> replaceBoardCell(T,15,C,wcut,Result);
						replaceBoardCell(T,15,C,bcut,Result));
		H is 0, replaceBoardCell(T,1,1,blank,Result)),
		
	(G = 1 -> Cut is 1; (H = 1 -> Cut is 1; Cut is 0)).


% Middle of Board
checkSquare(Board, R, C, X, Result, Cut) :-
	CheckTopRow is R-2,
	CheckBotRow is R+2,
	CheckLeftCol is C-1,
	CheckRightCol is C+1,

	nth1(CheckTopRow, Board, TopRow),
	nth1(CheckBotRow, Board, BotRow),

	nth1(CheckLeftCol, TopRow, TopLeft),
	nth1(CheckRightCol, TopRow, TopRight),
	nth1(CheckLeftCol, BotRow, BotLeft),
	nth1(CheckRightCol, BotRow, BotRight),

	Temp1 is R+1, Temp2 is R-1, Temp3 is C+1,


	
	(TopLeft = X -> 
		checkCut(Board, G, X, Temp2, C),
		(X = white -> replaceBoardCell(Board,Temp2,C,wcut,T1);
						replaceBoardCell(Board,Temp2,C,bcut,T1));
		G is 0, replaceBoardCell(Board,1,1,blank,T1)),


	
	(TopRight = X -> 
		checkCut(Board, H, X, Temp2, Temp3),
		(X = white -> replaceBoardCell(T1,Temp2,Temp3,wcut,T2);
						replaceBoardCell(T1,Temp2,Temp3,bcut,T2));
		H is 0, replaceBoardCell(T1,1,1,blank,T2)),


	
	(BotLeft = X -> 
		checkCut(Board, J, X, Temp1, C),
		(X = white -> replaceBoardCell(T2,Temp1,C,wcut,T3);
						replaceBoardCell(T2,Temp1,C,bcut,T3));
		J is 0, replaceBoardCell(T2,1,1,blank,T3)),

	
	
	(BotRight = X -> 
		checkCut(Board, K, X, Temp1, Temp3),
		(X = white -> replaceBoardCell(T3,Temp1,Temp3,wcut,Result);
						replaceBoardCell(T3,Temp1,Temp3,bcut,Result));
		K is 0, replaceBoardCell(T3,1,1,blank,Result)),
		
	(G = 1 -> Cut is 1; (H = 1 -> Cut is 1; (J = 1 -> Cut is 1; (K = 1 -> Cut is 1; Cut is 0)))).

	
% Check Victory Condition %

checkWhiteVictory(_, 18, _).
checkWhiteVictory(Board, N) :-
	nth1(N,Board,Row),
	nth1(Y, Row, white),

	Temp1 is Y-1,
	Temp2 is Y+1,
	Temp3 is N+2,
	Temp4 is N+1,
%	Temp5 is N-1,
	
replaceBoardCell(Board, N, Y, white_c, Result),

	(checkWhiteVictory(Board, Temp3, Y)->
	write('no');
	nth1(Temp4,Board,CutRow),
	nth1(Y, CutRow, Square1),
	nth1(Temp2, CutRow, Square2),
	(checkWhiteVictory(Board, N, Temp2)->
		write('no');
	(checkWhiteVictory(Board, N, Temp1)->
		write('no');
	(Square1 = wcut -> 
		(checkWhiteVictory(Board, Temp3, Temp1) -> 
			write('no');
			(Square2 = wcut -> 
				checkWhiteVictory(Board, Temp3, Temp2)));
		(Square2 = wcut -> 
			checkWhiteVictory(Board, Temp3, Temp2)))))).



checkWhiteVictory(Board, N, Y) :-
	
	nth1(N,Board,Row),
	nth1(Y, Row, Piece),

	Temp1 is Y-1,
	Temp2 is Y+1,
	Temp3 is N+2,
	Temp4 is N+1,

	(Piece = white ->
	
	replaceBoardCell(Board, N, Y, white_c, Result),
	(checkWhiteVictory(Result, Temp3, Y)->
	write('no');
	nth1(Temp4,Board,CutRow),
	nth1(Y, CutRow, Square1),
	nth1(Temp2, CutRow, Square2),

	(checkWhiteVictory(Result, N, Temp2)->
		write('no');
	(checkWhiteVictory(Result, N, Temp1)->
		write('no');

	(Square1 = wcut -> 
		(checkWhiteVictory(Result, Temp3, Temp1) -> 
			write('no');
			(Square2 = wcut -> 
				checkWhiteVictory(Result, Temp3, Temp2)));
		(Square2 = wcut -> 
			checkWhiteVictory(Result, Temp3, Temp2)))))); fail).


		
%  checkBlackVictory(_, _, 9).

% checkBlackVictory(_, 16):- fail.
checkBlackVictory(Board, N) :-

		% transpose(Board, Board1),
		
	nth1(N,Board,Row),
	nth1(Y, Row, black),
	Y = 1,
	% Temp1 is Y-1,
	Temp2 is Y+1,
	Temp3 is N+2,
	Temp4 is N+1,
	Temp5 is N-1,
	Temp6 is N-2,
	
	replaceBoardCell(Board, N, Y, black_c, Result),

	(checkBlackVictory(Board, N, Temp2)->
	write('no');
	nth1(Temp4,Board,CutRow),
	nth1(Temp2, CutRow, Square1),
	nth1(Temp5,Board,CutRow),
	nth1(Temp2, CutRow, Square2),
	(checkBlackVictory(Board, Temp3, Y)->
	write('no');
	(checkBlackVictory(Board, Temp6, Y)->
	write('no');
	
	(Square1 = bcut -> 
		(checkBlackVictory(Board, Temp3, Temp2) -> 
			write('no');
			(Square2 = bcut -> 
				checkBlackVictory(Board, Temp6, Temp2)));
		(Square2 = bcut -> 
			checkBlackVictory(Board, Temp6, Temp2)))))).
	
	
checkBlackVictory(Board, N, Y) :-
		
	nth1(N,Board,Row),
	nth1(Y, Row, Piece),
	Temp1 is Y-1,
	Temp2 is Y+1,
	Temp3 is N+2,
	Temp4 is N+1,
	Temp5 is N-1,
	Temp6 is N-2,
	
	Piece = black,
	(Y = 8-> true;
	
	replaceBoardCell(Board, N, Y, black_c, Result),
	(checkBlackVictory(Result, N, Temp2)->
	write('no');
	nth1(Temp4,Board,CutRow),
	nth1(Temp2, CutRow, Square1),
	nth1(Temp5,Board,CutRow),		
	nth1(Temp2, CutRow, Square2),
	
	% (checkBlackVictory(Result, Temp3, Y)->
		% 	write('no');
		
	(Square1 = bcut -> 
		(checkBlackVictory(Result, Temp3, Temp2) -> 
			write('no');
			(Square2 = bcut -> 
				checkBlackVictory(Result, Temp6, Temp2)));
		(Square2 = bcut -> 
			checkBlackVictory(Result, Temp6, Temp2);
		(checkBlackVictory(Board, Temp3, Y)->
		write('no');
		(checkBlackVictory(Board, Temp6, Y)->
		write('no'))))))).



% Places a piece on the board %

replaceBoardCell([L|Ls] , 1 , Y , Z , [R|Ls] ) :-
  replaceColumn(L,Y,Z,R).                             
  
replaceBoardCell([L|Ls] , X , Y , Z , [L|Rs] ) :-
  X > 1 ,                                
  X1 is X-1 ,                             
  replaceBoardCell(Ls , X1 , Y , Z , Rs ).                                       


replaceColumn([_|Cs] , 1 , Z , [Z|Cs] ) . 
replaceColumn([C|Cs] , Y , Z , [C|Rs] ) :- 
  Y > 1 ,                                    
  Y1 is Y-1 ,                            
  replaceColumn(Cs , Y1 , Z , Rs ).     

