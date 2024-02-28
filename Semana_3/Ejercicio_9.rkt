;Utilice la función map para definir la función eliminar_elemento que recibe un elemento E
;y una lista L y retorna la lista L sin el elemento E. Si el elemento no existe,
;retorna la lista L original.
(define (eliminar_elemento E L)
  (cond
    ((null? L) '()) ;si la lista esta vacia retornamos la lista vacía
    ((equal? (car L) E)(eliminar_elemento E (cdr L)))
    (else (cons (car L)(eliminar_elemento E (cdr L))))))

;para cada una de las sublistas se llama de forma recursiva con map
(define (eliminar_en_lista elemento lista)
  (map (lambda (x) (eliminar_elemento elemento x)) (list lista)))

(displayln (eliminar_en_lista 3 '(1 2 3 4 5)))
(displayln (eliminar_en_lista 6 '(1 2 3 4 5)))