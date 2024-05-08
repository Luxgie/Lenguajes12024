package main

import (
	"errors"
	"fmt"
)

type producto struct {
	nombre   string
	cantidad int
	precio   int
}

type listaProductos []producto

var lProductos listaProductos

const existenciaMinima int = 10

func (l *listaProductos) agregarProducto(nombre string, cantidad int, precio int) {
	index := l.buscarProductoIndex(nombre)
	if index != -1 {
		// Si el producto ya existe, incrementar la cantidad y actualizar el precio si es necesario
		(*l)[index].cantidad += cantidad
		if (*l)[index].precio != precio {
			(*l)[index].precio = precio
		}
	} else {
		// Agregar un nuevo producto a la lista
		*l = append(*l, producto{nombre: nombre, cantidad: cantidad, precio: precio})
	}
}

func (l *listaProductos) agregarProductos(varios ...producto) {
	for _, p := range varios {
		l.agregarProducto(p.nombre, p.cantidad, p.precio)
	}
}

func (l *listaProductos) buscarProductoIndex(nombre string) int {
	for i, p := range *l {
		if p.nombre == nombre {
			return i
		}
	}
	return -1
}

func (l *listaProductos) buscarProducto(nombre string) (producto, error) {
	index := l.buscarProductoIndex(nombre)
	if index != -1 {
		return (*l)[index], nil
	}
	return producto{}, errors.New("Producto no encontrado")
}

func (l *listaProductos) venderProducto(nombre string, cantidad int) error {
	index := l.buscarProductoIndex(nombre)
	if index == -1 {
		return errors.New("Producto no encontrado")
	}

	if (*l)[index].cantidad < cantidad {
		return errors.New("No hay suficiente cantidad disponible para la venta")
	}

	(*l)[index].cantidad -= cantidad

	if (*l)[index].cantidad <= 0 {
		// Eliminar el producto de la lista si la cantidad es cero o negativa
		l.eliminarProducto(index)
		fmt.Printf("Producto '%s' agotado y eliminado de la lista\n", nombre)
	}

	return nil
}

func (l *listaProductos) eliminarProducto(index int) {
	*l = append((*l)[:index], (*l)[index+1:]...)
}

func (l *listaProductos) modificarPrecioProducto(nombre string, nuevoPrecio int) error {
	index := l.buscarProductoIndex(nombre)
	if index == -1 {
		return errors.New("Producto no encontrado")
	}

	(*l)[index].precio = nuevoPrecio

	return nil
}

func (l *listaProductos) listarProductosMinimos() listaProductos {
	var productosMinimos listaProductos
	for _, p := range *l {
		if p.cantidad <= existenciaMinima {
			productosMinimos = append(productosMinimos, p)
		}
	}
	return productosMinimos
}

func llenarDatos() {
	// Agregar productos iniciales
	lProductos.agregarProducto("arroz", 15, 2500)
	lProductos.agregarProducto("frijoles", 4, 2000)
	lProductos.agregarProducto("leche", 8, 1200)
	lProductos.agregarProducto("café", 12, 4500)
}

func main() {
	llenarDatos()
	fmt.Println("Lista de productos:")
	fmt.Println(lProductos)

	// venta de productos
	err := lProductos.venderProducto("arroz", 5) // Vender 5 unidades de arroz
	if err != nil {
		fmt.Println("Error al vender producto:", err)
	}

	fmt.Println("Lista de productos después de la venta:")
	fmt.Println(lProductos)

	//  modificación de precio de producto
	err = lProductos.modificarPrecioProducto("café", 5000) // Modificar precio del café
	if err != nil {
		fmt.Println("Error al modificar precio:", err)
	}

	fmt.Println("Lista de productos después de modificar el precio del café:")
	fmt.Println(lProductos)

	// Listar productos con existencia mínima
	productosMinimos := lProductos.listarProductosMinimos()
	fmt.Println("Lista de productos con existencia mínima:")
	fmt.Println(productosMinimos)
}
