
(define listaProductos ;define define funciones, en este caso solo es una declaración
  '(("Arroz" 8 1800) ("Frijoles" 5 1200) ("Azúcar" 6 1100) ("Café" 2 2800) ("Leche" 6 1800)))

(define facturas
  (list
    '((("Arroz" 2 1800) ("Café" 1 2800)))
    '((("Azúcar" 4 1100) ("Leche" 2 1800)))
    '()))

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
          
;1)	(EVALUADO) Amplie al ejercicio visto en clase, permitiendo crear listas que representen
;facturas de ventas y creando las funciones necesarias para calcular a partir de dichas facturas
;(nuevas listas):

;a. El impuesto total a cancelar de la factura. Solo aquellos productos que sobrepasen un monto mayor
   ;definido de argumento en la función pagan impuesto y dicho impuesto es siempre el 13% sobre el monto.
;b. El monto total de la factura sin impuesto, sin importar ningún umbral

;; Función para calcular el impuesto total sobre los productos de una factura que superen un umbral de precio.
(define (calcularImpuestoTotal factura umbral)
  ;; Función auxiliar para calcular el impuesto sobre un solo producto.
  (define (calcularImpuestoProducto monto)
    (* monto 0.13)) ; Calcula el impuesto multiplicando el monto por 0.13 (13%).

  ;; Función para calcular el impuesto total sobre todos los productos de la factura que superen el umbral.
  (define (calcularImpuestoProductos factura)
    (foldl (lambda (producto acc)
             (cond ((> (caddr producto) umbral) ; Si el precio del producto supera el umbral,
                    (+ acc (calcularImpuestoProducto (* (cadr producto) (caddr producto))))) ; agrega el impuesto al acumulador.
                   (else acc))) ; De lo contrario, no se aplica impuesto al producto.
           0
           factura)) ; Comienza con un acumulador de 0 y aplica la función lambda a cada producto de la factura.

  (calcularImpuestoProductos factura)) ; Devuelve el impuesto total sobre los productos de la factura.

;; Función para calcular el monto total de la factura sin incluir impuestos.
(define (calcularTotalSinImpuesto factura)
  (foldl (lambda (producto acc)
           (+ acc (* (cadr producto) (caddr producto)))) ; Multiplica la cantidad por el precio y suma al acumulador.
         0
         factura)) ; Comienza con un acumulador de 0 y aplica la función lambda a cada producto de la factura.

;2) Haciendo uso de la función filter, implemente una función que, a partir de una lista de cadenas de
;parámetro,
;filtre aquellas que contengan una subcadena que el usuario indique en otro argumento. Ej
;sub_cadenas “la” [“la casa, “el perro”, “pintando la cerca”]
;[“la casa, “pintando la cerca”]

(define (contieneSubcadena? subcadena cadena)
  (not (equal? #f (regexp-match (regexp (string-append ".*" subcadena ".*")) cadena))))

(define (filtrarPorSubcadena subcadena listaCadenas)
  (filter (lambda (cadena)
            (contieneSubcadena? subcadena cadena))
          listaCadenas))



;; Ejemplo de uso EJERCICIO 1:

;; Ejemplo 1: Una factura con productos que superan el umbral y otros que no.
(define factura1 '(("Arroz" 2 1800) ("Café" 1 2800) ("Azúcar" 4 1100)))
(display "Impuesto total a cancelar (factura1): ")
(display (calcularImpuestoTotal factura1 1500)) ; Calcula el impuesto sobre los productos con precio superior a 1500.
(newline)
(display "Monto total de la factura sin impuesto (factura1): ")
(display (calcularTotalSinImpuesto factura1)) ; Calcula el monto total de la factura sin impuesto.
(newline)

;; Ejemplo 2: Una factura con todos los productos que superan el umbral.
(define factura2 '(("Leche" 2 1800) ("Café" 1 2800) ("Galletas" 3 2000)))
(display "Impuesto total a cancelar (factura2): ")
(display (calcularImpuestoTotal factura2 1500)) ; Calcula el impuesto sobre todos los productos.
(newline)
(display "Monto total de la factura sin impuesto (factura2): ")
(display (calcularTotalSinImpuesto factura2)) ; Calcula el monto total de la factura sin impuesto.
(newline)

;; Ejemplo 3: Una factura con productos por debajo del umbral.
(define factura3 '(("Manzanas" 5 120) ("Naranjas" 3 150) ("Plátanos" 2 180)))
(display "Impuesto total a cancelar (factura3): ")
(display (calcularImpuestoTotal factura3 200)) ; Calcula el impuesto sobre todos los productos.
(newline)
(display "Monto total de la factura sin impuesto (factura3): ")
(display (calcularTotalSinImpuesto factura3)) ; Calcula el monto total de la factura sin impuesto.
(newline)
(newline)
(newline)

;; Ejemplo de uso EJERCICIO 2:

(define listaEjemplo '("la casa" "el perro" "pintando la cerca"))
(display (filtrarPorSubcadena "la" listaEjemplo))

(define listaEjemplo2 '("la luna" "el sol" "bajo la sombra"))
(display (filtrarPorSubcadena "la" listaEjemplo2))

(define listaEjemplo3 '("lago" "lamentable" "luz"))
(display (filtrarPorSubcadena "la" listaEjemplo3))


