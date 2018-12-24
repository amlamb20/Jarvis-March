% Austin Lamb
% Transylvania University
% Principles of Programming Languages
% Dr. Moorman
% Nov 30 2018

% I'm my own Grandpa! A Prolog Program
% This program includes a set of facts that ultimately prove that,
% in the circumstances Ray Stevens sets, one person can indeed be
% their own grandfather.

% Note: It appears that Ray refers to biological and in-law/step
% relationships synonymously, so e.g. "mother" is true if biological
% mother or in-law mother is true.

% Sources Cited
% Prolog knowledge: https://www.youtube.com/watch?v=SykxWpFwMGs&t=1083s
% I'm My Own Grandpa: https://www.youtube.com/watch?v=eYlJH81dSiw

male(me).
male(my_father).
male(my_baby).
male(red_hairs_son).

female(my_wife).
female(red_hair_girl).

married(my_father, red_hair_girl).
married(me, my_wife).

parent(my_wife, red_hair_girl).
parent(my_father, me).
parent(me, red_hair_girl).
parent(me, my_baby).
parent(red_hair_girl, red_hairs_son).

not(X) :- X, !, fail.
not(_).

father(X, Y) :-
    male(X),
    parent(X, Y).

mother(X, Y) :-
    female(X),
    parent(Z, Y),
    married(Z, X).

grandma(X, Y) :-
    mother(X, Z),
    mother(Z, Y).
grandma(X, Y) :-
    mother(X, Z),
    father(Z, Y).

grandpa(X, Y) :-
    married(X, Z),
    grandma(Z, Y).

son_in_law(X, Y) :-
    male(X),
    married(Y, Z),
    parent(Z, C),
    married(C, X).

daughter_in_law(X, Y) :-
    female(X),
    married(Y, Z),
    parent(Z, C),
    married(C, X).

brother(X, Y) :-
    male(X),
    parent(Z, X),
    parent(Z, Y),
    not(X = Y).

brother_in_law(X, Y) :-
    married(Y, Z),
    brother(X, Z),
    not(X = Y).

uncle(X, Y) :-
    parent(Z, Y),
    brother(X, Z).
uncle(X, Y) :-
    parent(Z, Y),
    brother_in_law(X, Z).