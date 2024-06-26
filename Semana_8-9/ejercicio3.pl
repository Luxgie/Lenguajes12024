% Caso base: Cuando ambas cadenas son vac�as, la distancia de Hamming es 0.
distanciaH([], [], 0).

% Caso 1: Cuando una de las cadenas es vac�a y la otra no, la distancia de Hamming es la longitud de la cadena no vac�a.
distanciaH([], [_|T], D) :-
    length([_|T], D).

distanciaH([_|T], [], D) :-
    length([_|T], D).

% Caso recursivo: Comparar los primeros caracteres de ambas cadenas.
distanciaH([H1|T1], [H2|T2], D) :-
    H1 \= H2, % Si los caracteres en la misma posici�n son diferentes, incrementar la distancia.
    distanciaH(T1, T2, D1), % Calcular la distancia de Hamming para el resto de las cadenas.
    D is D1 + 1. % La distancia total es la distancia del resto m�s 1 debido a la diferencia.

distanciaH([H|T1], [H|T2], D) :-
    distanciaH(T1, T2, D). % Si los caracteres en la misma posici�n son iguales, continuar con el resto de las cadenas sin incrementar la distancia.

% Predicado de distanciaH para calcular la distancia de Hamming entre dos cadenas.
distanciaH(Str1, Str2, D) :-
    string_chars(Str1, Chars1), % Convertir la primera cadena en una lista de caracteres
    string_chars(Str2, Chars2), % Convertir la segunda cadena en una lista de caracteres
    distanciaH(Chars1, Chars2, D). % Calcular la distancia de Hamming entre las listas de caracteres.

%Ejemplos de Uso:

%distanciaH("romano", "comino", X). devuelve X = 2.
%distanciaH("romano", "camino", X). devuelve X = 3.
%distanciaH("roma", "comino", X). devuelve X = 2.

