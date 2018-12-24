Jarvis's March (Convex Hull)
/*
 * Convex Hull (Jarvis's March)
 *   The convex hull of a set of points is the smallest convex region
 *   containing the points
 */

/* jarvis(Points, ConvexHullVertices) is true if Points is a list of points  */
/*   in the form p(X,Y), and ConvexHullVertices are the vertices in the form */
/*   p(X,Y) of the convex hull of the Points, in clockwise order, starting   */
/*   and ending at the smallest point (as determined by X-values, and by     */
/*   Y-values to resolve ties). No three vertices of the convex hull will be */
/*   collinear.                                                              */
/* e.g. jarvis([p(0,6),p(3,7),p(4,6),p(4,5),p(3,4),p(2,4),p(5,0)],           */
/*             [p(0,6),p(3,7),p(4,6),p(5,0),p(0,6)]).                        */
jarvis(Points, [Pstart|ConvexHullVertices]):-
  min(Points, Pstart),
  jarvis_1([Pstart|Points], Pstart, Pstart, ConvexHullVertices).

jarvis_1([P1|Ps], P0, Pstart, [Q|Qs]):-
  jarvis_2(Ps, P1, P0, [], Ps1, Q),
  Q \= Pstart, !,
  jarvis_1(Ps1, Q, Pstart, Qs).
jarvis_1(_, _, Pstart, [Pstart]).

/* jarvis_2(Ps, P1, P0, [], Ps1, Q) is true if Q is that member of [P1|Ps]   */
/*   which is on or to the left of the line from P0 to P1, and for which     */
/*   the polar angle going anti-clockwise relative to P0 is the maximum.     */
/*   Ties are resolved by taking the point furthest from P0. Ps1 are the     */
/*   other elements of Ps (not necessarily in the same order), except that   */
/*   interior collinear points are discarded. (It still works if they are    */
/*   not discarded.)                                                         */
jarvis_2([], P, _, Ps, Ps, P).
jarvis_2([P0|Ps], P1, P0, Ps0, Ps1, Q):-!,
  jarvis_2(Ps, P1, P0, [P0|Ps0], Ps1, Q).
jarvis_2([P2|Ps], P1, P0, Ps0, Ps1, Q):-
  direction(P2, P0, P1, Direction),
  jarvis_3(Direction, Ps, P2, P1, P0, Ps0, Ps1, Q).

jarvis_3(left, Ps, P2, P1, P0, Ps0, Ps1, Q):-!,
  jarvis_2(Ps, P2, P0, [P1|Ps0], Ps1, Q).
jarvis_3(right, Ps, P2, P1, P0, Ps0, Ps1, Q):-!,
  jarvis_2(Ps, P1, P0, [P2|Ps0], Ps1, Q).
jarvis_3(collinear, Ps, P2, P1, P0, Ps0, Ps1, Q):-
  is_nearer(P2, P1, P0), !,
  /* P2 is nearer to P0 than P1 is */
  jarvis_2(Ps, P1, P0, Ps0, Ps1, Q).
jarvis_3(collinear, Ps, P2, _, P0, Ps0, Ps1, Q):-
  /* P1 is nearer to P0 than P2 is */
  jarvis_2(Ps, P2, P0, Ps0, Ps1, Q).

/* min(List, Min) is true if Min is the smallest element in List as          */
/*   determined by lt/2.                                                     */
min([X|Xs], Y):-min_1(Xs, X, Y).

min_1([], X, X).
min_1([Y|Ys], X, Z):-lt(Y, X), !, min_1(Ys, Y, Z).
min_1([_|Ys], X, Z):-min_1(Ys, X, Z).

lt(p(X,_), p(X1,_)):-X < X1, !.
lt(p(X,Y), p(X,Y1)):-Y < Y1.

/* direction(Pa, Pb, Pc, Dirn) is true if Pa is strictly to the left of the  */
/*   directed line from Pb to Pc, and Dirn=left; Pa is strictly to the right */
/*   of the directed line from Pb to Pc, and Dirn=right; or Pa, Pb and Pc    */
/*   are collinear, and Dirn=collinear.                                      */
direction(p(Xa,Ya), p(Xb,Yb), p(Xc,Yc), Dirn):-
  Area is (Xb-Xa) * (Yc-Ya) - (Xc-Xa) * (Yb-Ya),
  direction_1(Area, Dirn).

direction_1(Area, left):-Area > 0.0, !.
direction_1(Area, right):-Area < 0.0, !.
direction_1(_, collinear).

/* is_nearer(Pa, Pb, Pc) is true if Pa is strictly nearer to Pc than Pb is.  */
is_nearer(p(Xa,Ya), p(Xb,Yb), p(Xc,Yc)):-
  Xa_Xc is Xa - Xc,
  Ya_Yc is Ya - Yc,
  Xb_Xc is Xb - Xc,
  Yb_Yc is Yb - Yc,
  (Xa_Xc)*(Xa_Xc) + (Ya_Yc)*(Ya_Yc) < (Xb_Xc)*(Xb_Xc) + (Yb_Yc)*(Yb_Yc).
