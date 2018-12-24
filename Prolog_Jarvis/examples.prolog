
palindrome(_).
palindrome([X|T]) :-
    append(S, [X], T),
    palindrome(S).

next_town(town1, town2).
next_town(town2, town3).
next_town(town3, town4).
next_town(town4, town5).
next_town(town5, town6).

can_get(X, X).
can_get(Start, Finish) :-
    next_town(Start, X),
    can_get(X, Finish).
