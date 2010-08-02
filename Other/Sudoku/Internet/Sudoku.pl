% Sudoku Solver
%
% Author: Miles Barr
% Version: 1.0
%
% Example Usage:
%
% Board = [ [_,_,3,_,4,9,_,_,8],
%           [_,1,_,5,_,_,_,3,_],
%           [8,_,7,3,_,_,_,_,_],
%           [_,6,8,9,_,_,_,_,5],
%           [2,_,_,_,_,_,_,_,6],
%           [4,_,_,_,_,6,7,1,_],
%           [_,_,_,_,_,5,9,_,3],
%           [_,8,_,_,_,1,_,6,_],
%           [9,_,_,2,3,_,1,_,_]
%         ],
% sudoku(Board),
% print_board(Board).


/*
Board = [[_,_,3,_,4,9,_,_,8], [_,1,_,5,_,_,_,3,_], [8,_,7,3,_,_,_,_,_], [_,6,8,9,_,_,_,_,5], [2,_,_,_,_,_,_,_,6], [4,_,_,_,_,6,7,1,_], [_,_,_,_,_,5,9,_,3], [_,8,_,_,_,1,_,6,_], [9,_,_,2,3,_,1,_,_]], sudoku(Board), print_board(Board), fail.

% Grid 13
Board = [[3, _, _, _, _, _, _, _, _], [_, _, 5, _, _, 9, _, _, _], [2, _, _, 5, _, 4, _, _, _], [_, 2, _, _, _, _, 7, _, _], [1, 6, _, _, _, _, _, 5, 8], [7, _, 4, 3, 1, _, 6, _, _], [_, _, _, 8, 9, _, 1, _, _], [_, _, _, _, 6, 7, _, 8, _], [_, _, _, _, _, 5, 4, 3, 7]], sudoku(Board), print_board(Board), fail.

% Hardest
Board = [[8, 5, _, _, _, 2, 4, _, _], [7, 2, _, _, _, _, _, _, 9], [_, _, 4, _, _, _, _, _, _], [_, _, _, 1, _, 7, _, _, 2], [3, _, 5, _, _, _, 9, _, _], [_, 4, _, _, _, _, _, _, _], [_, _, _, _, 8, _, _, 7, _], [_, 1, 7, _, _, _, _, _, _], [_, _, _, _, 3, 6, _, 4, _]], sudoku(Board), print_board(Board), fail.

% Hard 04
Board = [[4, 8, _, 3, _, _, _, _, _], [_, _, _, _, _, _, _, 7, 1], [_, 2, _, _, _, _, _, _, _], [7, _, 5, _, _, _, _, 6, _], [_, _, _, 2, _, _, 8, _, _], [_, _, _, _, _, _, _, _, _], [_, _, 1, _, 7, 6, _, _, _], [3, _, _, _, _, _, 4, _, _], [_, _, _, _, 5, _, _, _, _]], sudoku(Board), print_board(Board), fail.
*/


:- use_module(library('clp/bounds')).
:- use_module(library('lists')).

% Our general constraint is that each set of 9 (row, column or 3x3 grid) is made
% up from the numbers 1-9, and each number is not repeated.
valid(L) :- L in 1..9, all_different(L).

/*
L = [A1, A2, A3, A4, A5, A6], L1 = [A1, A2, A3], L2 = [A4, A5, A6], valid(L1), valid(L2), label(L).
valid([1, 3, 4, X]), valid([4, 6, X]), label([X]).
L1 = [_, X], L2 = [X, Y], L3 = [Y, _], valid(L1), valid(L2), valid(L3), flatten([L1, L2, L3], L), label(L), write(L), nl, fail.
L1 = [_, X], L2 = [X, Y], L3 = [Y, _], valid(L1), valid(L2), valid(L3), flatten([L1, L2, L3], L), findall(L, label(L), LL), length(LL, Len), write(Len), nl, fail.
*/

% Transpose function from Worksheet 16 of 'Clause and Effect'
transpose([[]|_],[]).
transpose(R,[H|C]) :- chopcol(R,H,T), transpose(T,C).
chopcol([],[],[]).
chopcol([[H|T]|R],[H|Hs],[T|Ts]) :- chopcol(R,Hs,Ts).

% Describe 3 grids in terms of 3 rows
% TODO: There must be a better way to do this.
grids([E11,E12,E13,E14,E15,E16,E17,E18,E19],
      [E21,E22,E23,E24,E25,E26,E27,E28,E29],
      [E31,E32,E33,E34,E35,E36,E37,E38,E39],
      [E11,E12,E13,E21,E22,E23,E31,E32,E33],
      [E14,E15,E16,E24,E25,E26,E34,E35,E36],
      [E17,E18,E19,E27,E28,E29,E37,E38,E39]).

% Print a board
print_board([]).
print_board([H|T]) :- write(H), nl, print_board(T).

% Sudoku solving function. 
%
% Input is nine lists of nine integers
sudoku(Board) :-
  % Break the board down into rows
  Board = [R1, R2, R3, R4, R5, R6, R7, R8, R9],
  % Transpose the board to get the columns
  transpose(Board, [C1, C2, C3, C4, C5, C6, C7, C8, C9]),
  % Cut up the rows into 3x3 grids
  grids(R1,R2,R3,G1,G2,G3),
  grids(R4,R5,R6,G4,G5,G6),
  grids(R7,R8,R9,G7,G8,G9),
  % Each row contains unique entries
  valid(R1), valid(R2), valid(R3),
  valid(R4), valid(R5), valid(R6),
  valid(R7), valid(R8), valid(R9),
  % Each column contains unique entries
  valid(C1), valid(C2), valid(C3),
  valid(C4), valid(C5), valid(C6),
  valid(C7), valid(C8), valid(C9),
  % Each grid contains unique entries
  valid(G1), valid(G2), valid(G3),
  valid(G4), valid(G5), valid(G6),
  valid(G7), valid(G8), valid(G9),

  % Turn the board into a list of 81 variables
  flatten(Board, Elements),
  %sign a value to each variable
  label(Elements).
