% Example graph esquinas
% peso :
% distancia + semaforos(numero de semaforos) + transito(1:menor,2:intermedio,3:mayor)
esquina(a, b, 4).
esquina(c, a, 2).
esquina(a, c, 2).
esquina(b, c, 1).
esquina(b, d, 5).
esquina(c, d, 8).
esquina(c, e, 10).
esquina(d, e, 2).
esquina(d, f, 6).
esquina(e, f, 3).
esquina(e, c, 10).
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
        (esquina(Node, Neighbor, Weight), \+ member(Neighbor, Visited), NewCost is Cost + Weight),
        Neighbors),
    append(Queue, Neighbors, NewQueue),
    sort(NewQueue, SortedQueue),
    dijkstra(SortedQueue, Goal, [Node|Visited], ResultPath, ResultCost).

% Helper predicate to reverse a list
reverse(List, RevList) :- reverse(List, [], RevList).

reverse([], RevList, RevList).
reverse([H|T], Acc, RevList) :- reverse(T, [H|Acc], RevList).