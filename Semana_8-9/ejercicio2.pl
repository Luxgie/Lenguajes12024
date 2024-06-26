
% Caso base: Aplanar una lista vac�a devuelve una lista vac�a.
aplanar([], []).

% Caso base: Aplanar un elemento que no es una lista devuelve una lista con ese elemento.
aplanar(X, [X]) :-
    \+ is_list(X). % X no es una lista

% Caso recursivo: Aplanar una lista que contiene elementos (incluidas sublistas).
aplanar([H|T], Result) :-
    aplanar(H, FlatH),      % Aplanar el primer elemento H
    aplanar(T, FlatT),      % Aplanar el resto de la lista T
    append(FlatH, FlatT, Result). % Concatenar la lista aplanada de H con la lista aplanada de T para obtener el resultado final.

% Regla para aplanar una lista que es un solo elemento (no una lista anidada).
aplanar(X, [X]) :-
    \+ is_list(X). % X no es una lista

% Regla para aplanar una lista que es una lista vac�a.
aplanar([], []).

% Regla para aplanar una lista que contiene elementos anidaplanar([H|T], Flat) :-
    aplanar(H, FlatH), % Aplanar el primer elemento H
    aplanar(T, FlatT), % Aplanar el resto de la lista T
    append(FlatH, FlatT, Flat). % Concatenar la lista aplanada de H con la lista aplanada de T para obtener el resultado final.

% append(L1, L2, L3): Concatena las listas L1 y L2 para obtener L3.
append([], L, L).
append([H|T], L2, [H|L3]) :-
    append(T, L2, L3).

% Ejemplos de Uso:

% aplanar([1,2,[3,[4,5],[6,7]]], X). devuelve X = [1, 2, 3, 4, 5, 6, 7].

% aplanar([a,[b,c],[d,[e,f,g],h],i], X). devuelve X = [a, b, c, d, e, f, g, h, i].
% aplanar([1,[2,3],[[4],[5]]], X). devuelve X = [1, 2, 3, 4, 5].
