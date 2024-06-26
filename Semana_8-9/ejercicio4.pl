% Hechos: definici�n de platos, categor�as y calor�as
plato(entrada, guacamole, 200).
plato(entrada, ensalada, 150).
plato(entrada, consome, 300).
plato(entrada, tostadas_caprese, 250).
plato(carne, filete_cerdo, 400).
plato(carne, pollo_horno, 280).
plato(carne, carne_salsa, 320).
plato(pescado, tilapia, 160).
plato(pescado, salmon, 300).
plato(pescado, trucha, 225).
plato(postre, flan, 200).
plato(postre, nueces_miel, 500).
plato(postre, naranja_confitada, 450).
plato(postre, flan_coco, 375).

% Regla para definir un plato principal (carne o pescado)
plato_principal(Plato) :-
    plato(carne, Plato, _).
plato_principal(Plato) :-
    plato(pescado, Plato, _).

% Regla para definir una comida completa (entrada, plato principal y postre)
comida_completa(Entrada, PlatoPrincipal, Postre) :-
    plato(entrada, Entrada, _),
    plato_principal(PlatoPrincipal),
    plato(postre, Postre, _).

% Regla para calcular el total de calor�as de una comida
calorias_comida(Entrada, PlatoPrincipal, Postre, CaloriasTotales) :-
    plato(entrada, Entrada, CalEntrada),
    plato_principal(PlatoPrincipal, CalPlatoPrincipal),
    plato(postre, Postre, CalPostre),
    CaloriasTotales is CalEntrada + CalPlatoPrincipal + CalPostre.

% Regla para generar combinaciones v�lidas de comidas que no excedan un m�ximo de calor�as y no repitan elementos
combinacion_comidas(MaxCalorias, Combinacion) :-
    comida_completa(Entrada, PlatoPrincipal, Postre),
    calorias_comida(Entrada, PlatoPrincipal, Postre, CaloriasTotales),
    CaloriasTotales =< MaxCalorias,
    \+ member(Entrada, PlatoPrincipal), % Entrada no debe repetirse en PlatoPrincipal
    \+ member(Entrada, Postre),        % Entrada no debe repetirse en Postre
    \+ member(PlatoPrincipal, Postre),  % PlatoPrincipal no debe repetirse en Postre
    Combinacion = [Entrada, PlatoPrincipal, Postre]. % Construir la combinaci�n de comidas

% Regla para consultar las primeras N combinaciones v�lidas que no excedan un m�ximo de calor�as
primeras_combinaciones(MaxCalorias, N, Combinaciones) :-
    findall(Combinacion, combinacion_comidas(MaxCalorias, Combinacion), ListaCombinaciones),
    length(ListaCombinaciones, Longitud),
    ( Longitud >= N ->
        length(Combinaciones, N),
        append(Combinaciones, _, ListaCombinaciones)
    ;
        Combinaciones = ListaCombinaciones
    ).
%Ejemplos de Uso:

% primeras_combinaciones(800, 5, Combinaciones).: Devuelve las primeras 5
% combinaciones de comidas que no excedan 800 calor�as.
% primeras_combinaciones(600, 10, Combinaciones).: Devuelve las primeras
% 10 combinaciones de comidas que no excedan 600 calor�as.%
