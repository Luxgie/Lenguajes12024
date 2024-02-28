(define (calcular-monto capital interes años)
  (if (= años 0)
      capital
      (let ((monto-anterior (calcular-monto capital interes (- años 1)))) ;let para declarar variables locales
        (+ monto-anterior (* monto-anterior interes)))))

;; Ejemplo de uso 
(displayln "Capital\tInterés\tAños\tResultado")
(displayln "-------------------------------------")
(displayln (format "2000\t0.10\t0\t~a" (calcular-monto 2000 0.10 0)))
(displayln (format "2000\t0.10\t1\t~a" (calcular-monto 2000 0.10 1)))
(displayln (format "2000\t0.10\t2\t~a" (calcular-monto 2000 0.10 2)))
(displayln (format "2000\t0.10\t3\t~a" (calcular-monto 2000 0.10 3)))
