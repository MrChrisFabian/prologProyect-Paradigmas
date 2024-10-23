% Example graph edges
% peso :
% distancia + semaforos(numero de semaforos) + transito(1:menor,2:intermedio,3:mayor)
edge(a, b, 4).
edge(a, c, 2).
edge(b, c, 1).
edge(b, d, 5).
edge(c, d, 8).
edge(c, e, 10).
edge(d, e, 2).
edge(d, f, 6).
edge(e, f, 3).

% Main dijkstra predicate to be called by the user
dijkstra(Start, Goal, Path, Cost) :-
    dijkstra([[0, Start]], Goal, [], RevPath, Cost),
    reverse(RevPath, Path).

% Base case: when the goal node is reached
dijkstra([[Cost, Goal|Path]|_], Goal, _, [Goal|Path], Cost).

% Recursive case: explore neighbors and continue the search
dijkstra([[Cost, Node|Path]|Queue], Goal, Visited, ResultPath, ResultCost) :-
    findall(
        [NewCost, Neighbor, Node|Path],
        (edge(Node, Neighbor, Weight), \+ member(Neighbor, Visited), NewCost is Cost + Weight),
        Neighbors),
    append(Queue, Neighbors, NewQueue),
    sort(NewQueue, SortedQueue),
    dijkstra(SortedQueue, Goal, [Node|Visited], ResultPath, ResultCost).

% Helper predicate to reverse a list
reverse(List, RevList) :- reverse(List, [], RevList).

reverse([], RevList, RevList).
reverse([H|T], Acc, RevList) :- reverse(T, [H|Acc], RevList).