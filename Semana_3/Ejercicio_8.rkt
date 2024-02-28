(define (pertenece? elemento conjunto)
  (cond
    ((null? conjunto) #f)
    ((equal? elemento (car conjunto)) #t)
    (else (pertenece? elemento (cdr conjunto))))) ;me va a ir regresando la lista sin el primer elemento

(define (sub-conjunto? conjunto1 conjunto2)
  (cond
    ((null? conjunto1) #t)  ; Si conjunto1 es vacío, siempre es subconjunto de cualquier conjunto
    ((pertenece? (car conjunto1) conjunto2)   ; Si el primer elemento de conjunto1 está en conjunto2
     (sub-conjunto? (cdr conjunto1) conjunto2)) ; Verifica el resto de elementos de conjunto1
    (else #f)))  ; Si el primer elemento de conjunto1 no está en conjunto2, entonces conjunto1 no puede ser subconjunto

; Ejemplos de uso:
(displayln (sub-conjunto? '() '(a b c d e f)))        ; Imprime #t
(displayln (sub-conjunto? '(a b c) '(a b c d e f)))   ; Imprime #t
(displayln (sub-conjunto? '(a b x) '(a b c d e f)))   ; Imprime #f
