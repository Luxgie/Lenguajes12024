(define listaProductos ;define define funciones, en este caso solo es una declaración
  '(("Arroz" 8 1800) ("Frijoles" 5 1200) ("Azúcar" 6 1100) ("Café" 2 2800) ("Leche" 6 1800)))

(define (agregarProducto Lista nombre cantidad precio)
  (cond ((null? Lista)
         (list (list nombre cantidad precio)))
        ((equal? nombre (caar Lista))
         (cons (list
                (caar Lista)                ;construya una lista con nombre
                (+ (cadar Lista) cantidad)  ;el car del cdr del car ó (list-ref () ())
                precio)                     ;
                (cdr Lista)))               ; 
        (else
         (cons (car Lista) (agregarProducto (cdr Lista) nombre cantidad precio)))))

(define (venderProducto Lista nombre cantidad)
  (cond ((null? Lista)
         (display "No existe ese producto para vender")
         '())
         (list (list nombre cantidad))
         ((equal? nombre (caar Lista))
          (cons (list
                 (caar Lista)
                 (- (list-ref (car Lista) 1) cantidad)
                 (list-ref (car Lista) 2))
                 (cdr Lista)))
         (else
          (cons (car Lista) 
                (venderProducto (cdr Lista) nombre cantidad)))))

(define (existenciasMinimas Lista cantidad)
  (filter (lambda (x) (<= (cadr x) cantidad))
          Lista))
;Haciendo uso de la función filter, implemente una función que, a partir de una lista de cadenas de
;parámetro,
;filtre aquellas que contengan una subcadena que el usuario indique en otro argumento. Ej
;sub_cadenas “la” [“la casa, “el perro”, “pintando la cerca”]
;[“la casa, “pintando la cerca”]



