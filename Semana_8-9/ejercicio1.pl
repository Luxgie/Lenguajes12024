% Caso base: Si la lista A es vacía, entonces es un subconjunto de cualquier lista.
sub_conjunto([], _).

% Caso recursivo: Verificar si el primer elemento de A está en B y luego verificar el resto de A.
sub_conjunto([X|A], B) :-
    member(X, B),     % X está en B
    select(X, B, B1), % Eliminar X de B para obtener B1
    sub_conjunto(A, B1). % Verificar el resto de A en B1

% member(X, L): X es un elemento de la lista L.
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

% select(X, L, L1): L1 es la lista L con una ocurrencia de X eliminada.
select(X, [X|T], T).
select(X, [H|T], [H|T1]) :- select(X, T, T1).

% Ejemplos de Uso:

% sub_conjunto([], [1,2,3,4,5]).        true.
% sub_conjunto([1,2,3], [1,2,3,4,5]).   true.
% sub_conjunto([1,2,6], [1,2,3,4,5]).   false.
