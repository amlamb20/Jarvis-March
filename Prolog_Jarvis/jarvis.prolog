%%%% Austin Lamb
%%%% Principles of Programming Language
%%%% Dr. Moorman
%%%% December 12 2018

%%%% Jarvis' March
%%%% This is an implementation of the Jarvis' March algorithm in Prolog.
%%%% Jarvis' March is an algorithm for finding the convex hull of a graph,
%%%% the convex hull being the smallest path between points that encloses all points of the graph.

% finds the lowest point in a graph
lowest_point([X], X).
lowest_point([[_, _, Y1], [Name2, X2, Y2] | Tail], Min) :-
    Y2 < Y1,
    lowest_point([[Name2, X2, Y2] | Tail], Min).
lowest_point([[Name1, X1, Y1], [_, _, Y2] | Tail], Min) :-
    Y2 > Y1,
    lowest_point([[Name1, X1, Y1] | Tail], Min).
lowest_point([[Name1, X1, Y1], [_, X2, Y2] | Tail], Min) :-
    Y2 = Y1,
    X2 > X1,
    lowest_point([[Name1, X1, Y1] | Tail], Min).
lowest_point([[_, X1, Y1], [Name2, X2, Y2] | Tail], Min) :-
    Y2 = Y1,
    X2 < X1,
    lowest_point([[Name2, X2, Y2] | Tail], Min).

% creates a list of angles between a reference point and all other points in a graph
% converts angles of 3.14... to -314 so they are found by largest_angle.
% if two points are the same, the angle is set to 111, which is skipped by smallest_angle.
find_angles(_,[],[]).
find_angles([Name1, X1, Y1], [[_, X2, Y2] | Points], [ThisAngle | Angles]) :-
    X1 \= X2,
    Y1 \= Y2,
    ThisAngle is atan2(Y2-Y1, X2-X1),
    find_angles([Name1, X1, Y1], Points, Angles).
find_angles([Name1, X1, Y1], [[_, X2, Y2] | Points], [ThisAngle | Angles]) :-
    X1 = X2,
    Y1 \= Y2,
    ThisAngle is atan2(Y2-Y1, X2-X1),
    find_angles([Name1, X1, Y1], Points, Angles).
find_angles([Name1, X1, Y1], [[_, X2, Y2] | Points], [ThisAngle | Angles]) :-
    Y1 = Y2,
    X2 < X1,
    ThisAngle is -314,
    find_angles([Name1, X1, Y1], Points, Angles).
find_angles([Name1, X1, Y1], [[_, X2, Y2] | Points], [ThisAngle | Angles]) :-
    Y1 = Y2,
    X2 > X1,
    ThisAngle is 0,
    find_angles([Name1, X1, Y1], Points, Angles).
find_angles([Name1, X1, Y1], [[CurrPt, _, _] | Points], [ThisAngle | Angles]) :-
    Name1 = CurrPt,
    ThisAngle is 111,
    find_angles([Name1, X1, Y1], Points, Angles).

% removes negatives from a list of numbers
remove_negatives([], []).
remove_negatives([Head | Tail], Ans) :-
    Head < 0,
    remove_negatives(Tail, Ans).
remove_negatives([Head | Tail], [Head | Ans]) :-
    Head >= 0,
    remove_negatives(Tail, Ans).

% removes positives from a list of numbers
remove_positives([], []).
remove_positives([Head | Tail], Ans) :-
    Head > 0,
    remove_positives(Tail, Ans).
remove_positives([Head | Tail], [Head | Ans]) :-
    Head =< 0,
    remove_positives(Tail, Ans).

% finds the minimum number in a list
find_min(X, [X]).
find_min(X, [H|T]) :- find_min(X, T), X =< H.
find_min(H, [H|T]) :- find_min(X, T), X > H.

% finds the smallest angle relative to a point
smallest_angle(RefPt, Graph, Answer) :-
    find_angles(RefPt, Graph, ListOfAngles),
    remove_negatives(ListOfAngles, NewListOfAngles),
    find_min(SmallestAngle, NewListOfAngles),
    SmallestAngle \= 111,
    nth0(Index, ListOfAngles, SmallestAngle),
    nth0(Index, Graph, Answer).

% finds the largest angle relative to a point
largest_angle(RefPt, Graph, Answer) :-
    find_angles(RefPt, Graph, ListOfAngles),
    remove_positives(ListOfAngles, NewListOfAngles),
    find_min(LargestAngle, NewListOfAngles),
    nth0(Index, ListOfAngles, LargestAngle),
    nth0(Index, Graph, Answer).

%%%% Main Jarvis algorithm

% a graph of 1 to 3 points will return those points
jarvis([Pt1], [Pt1]) :- !.
jarvis([Pt1, Pt2], [Pt1, Pt2]) :- !.
jarvis([Pt1, Pt2, Pt3], [Pt1, Pt2, Pt3]) :- !.

% part 1: finds lowest point first
% takes in a graph and a hull
jarvis(Graph, Hull) :-
    lowest_point(Graph, StartPt),
    jarvis_smallest_angle(Graph, StartPt, StartPt, Hull), !.

% part 2: searches for smallest angles until none are found
% takes in a graph, starting point, Px, and the hull
jarvis_smallest_angle(Graph, StartPt, Px, [Px | Hull]) :-
    smallest_angle(Px, Graph, Py),
    jarvis_smallest_angle(Graph, StartPt, Py, Hull).
jarvis_smallest_angle(Graph, StartPt, Px, Hull) :-
    jarvis_largest_angle(Graph, StartPt, Px, Hull), !.

% part 3: searches for largest angles until StartPt is reached
% takes in a graph, starting point, Px, and the hull
jarvis_largest_angle(_, StartPt, StartPt, []).
jarvis_largest_angle(Graph, StartPt, Px, [Px | Hull]) :-
    largest_angle(Px, Graph, Py),
    jarvis_largest_angle(Graph, StartPt, Py, Hull).
