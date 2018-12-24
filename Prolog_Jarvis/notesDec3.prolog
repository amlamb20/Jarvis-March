minimum([X], X).

minimum([Head, Next|Tail], Minimum) :-
    Head <= Next,
    minimum([Head|Tail], Minimum).
    

minimum([Head, Next|Tail], Minimum) :-
    Head > Next,
    minimum([Next|Tail], Minimum).

lowest_point([X], X).
lowest_point([[Name1, X1, Y1], [Name2, X2, Y2] | Tail], Min) :-
    Y2 < Y1,
    lowest_point([[Name2, X2, Y2] | Tail], Min).
lowest_point([[Name1, X1, Y1], [Name2, X2, Y2] | Tail], Min) :-
    Y2 > Y1
    lowest_point([[Name1, X1, Y1] | Tail], Min).



