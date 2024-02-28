;ordena de menor a mayor los elementos de una lista
;tomando dos listas como argumentos, y creando una nueva
;para colocar los elementos ya ordenados.
(define(merge lista1 lista2)
  (cond
    ((null? lista1) lista2);pregunta si la lista1 esta vacía, si es así, devuelve la lista2 
    ((null? lista2) lista1);pregunta si la lista2 está vacía, si es así, devuelve la lista1
    ((< (car lista1) (car lista2));el car de lista1 es menor que el car de lista2?
     (cons (car lista1) (merge (cdr lista1) lista2)));devuelve el primer elemento de la lista1 y la lista si ese elemento junto a a la lista2
    (else
     (cons (car lista2) (merge lista1 (cdr lista2)))));;devuelve el primer elemento de la lista2 y la lista si ese elemento junto a a la lista1
)
;main
(displayln (merge '(6 4 1 5 7) '(4 6 8 2)))
       
