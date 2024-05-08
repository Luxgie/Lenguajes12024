package main

import (
	"fmt"
	"sort"
	"strings"
)

// Definición de la estructura infoCliente
type infoCliente struct {
	nombre string
	correo string
	edad   int32
}

// Definición del tipo listaClientes como un slice de infoCliente
type listaClientes []infoCliente

// Función filter2 genérica para filtrar elementos de una lista
func filter2[T any](list []T, f func(T) bool) []T {
	var filtered []T
	for _, v := range list {
		if f(v) {
			filtered = append(filtered, v)
		}
	}
	return filtered
}

// Función map2 genérica para aplicar una función a cada elemento de una lista
func map2[P1, P2 any](list []P1, f func(P1) P2) []P2 {
	mapped := make([]P2, len(list))
	for i, e := range list {
		mapped[i] = f(e)
	}
	return mapped
}

// Función reduce genérica para reducir una lista a un solo valor
func reduce(list []int32) int32 {
	var result int32 = 0
	for _, v := range list {
		result += v
	}
	return result
}

// Función para agregar un cliente a la lista de clientes
func (lc *listaClientes) agregarCliente(nombre, correo string, edad int32) {
	*lc = append(*lc, infoCliente{nombre: nombre, correo: correo, edad: edad})
}

// Función para filtrar clientes cuyos correos contienen el apellido
func listaClientes_ApellidoEnCorreo(clientes *listaClientes) listaClientes {
	// Definir función de filtro para identificar correos con apellido
	filtroApellido := func(c infoCliente) bool {
		apellido := strings.Split(c.nombre, " ")[1]
		return strings.Contains(c.correo, apellido)
	}

	// Aplicar filtro y obtener lista de clientes con correos que contienen el apellido
	return filter2(*clientes, filtroApellido)
}

// Función para contar clientes cuyos correos pertenecen a dominios de Costa Rica
func cantidadCorreosCostaRica(clientes *listaClientes) int {
	// Definir función de filtro para identificar correos de Costa Rica
	esCorreoCostaRica := func(c infoCliente) bool {
		return strings.HasSuffix(strings.ToLower(c.correo), ".cr")
	}

	// Aplicar filtro y contar clientes con correos de Costa Rica
	clientesCostaRica := filter2(*clientes, esCorreoCostaRica)
	return len(clientesCostaRica)
}

// Función para sugerir correos alternativos para clientes
func clientesSugerenciasCorreos(clientes *listaClientes) listaClientes {
	// Definir función de transformación para modificar correos
	transformacionCorreo := func(c infoCliente) infoCliente {
		if !strings.Contains(c.correo, c.nombre) {
			// Modificar el correo con un formato sugerido que incluya el nombre
			nuevoCorreo := fmt.Sprintf("%s_%s@example.com", strings.ToLower(c.nombre), strings.ReplaceAll(c.nombre, " ", "_"))
			return infoCliente{nombre: c.nombre, correo: nuevoCorreo, edad: c.edad}
		}
		// Mantener el cliente original si el correo ya hace referencia al nombre
		return c
	}

	// Aplicar transformación a todos los clientes en la lista
	return map2(*clientes, transformacionCorreo)
}

// Función para obtener una lista ordenada alfabéticamente de correos de clientes
func correosOrdenadosAlfabeticos(clientes *listaClientes) []string {
	// Función para extraer correos de clientes
	extraerCorreos := func(c infoCliente) string {
		return c.correo
	}

	// Aplicar map para obtener una lista de correos
	correos := map2(*clientes, extraerCorreos)

	// Ordenar alfabéticamente la lista de correos
	sort.Strings(correos)

	return correos
}

func main() {
	// Crear una lista de clientes y agregar clientes
	var listaClientesNegocio listaClientes
	listaClientesNegocio.agregarCliente("Oscar Viquez", "oviquez@tec.ac.cr", 44)
	listaClientesNegocio.agregarCliente("Pedro Perez", "elsegundo@gmail.com", 30)
	listaClientesNegocio.agregarCliente("Maria Lopez", "mlopez@hotmail.com", 18)
	listaClientesNegocio.agregarCliente("Juan Rodriguez", "jrodriguez@gmail.com", 25)
	listaClientesNegocio.agregarCliente("Luisa Gonzalez", "muyseguro@tec.ac.cr", 67)
	listaClientesNegocio.agregarCliente("Marco Rojas", "loquesea@hotmail.com", 47)
	listaClientesNegocio.agregarCliente("Marta Saborio", "msaborio@gmail.com", 33)
	listaClientesNegocio.agregarCliente("Camila Segura", "csegura@ice.co.cr", 19)
	listaClientesNegocio.agregarCliente("Fernando Rojas", "frojas@estado.gov", 27)
	listaClientesNegocio.agregarCliente("Rosa Ramirez", "risuenna@gmail.com", 50)

	// Mostrar lista de clientes
	fmt.Println("Lista de clientes:")
	fmt.Println(listaClientesNegocio)

	//función listaClientes_ApellidoEnCorreo
	clientesConApellidoEnCorreo := listaClientes_ApellidoEnCorreo(&listaClientesNegocio)
	fmt.Println("Clientes cuyos correos contienen el apellido:")
	fmt.Println(clientesConApellidoEnCorreo)

	// función cantidadCorreosCostaRica
	cantidad := cantidadCorreosCostaRica(&listaClientesNegocio)
	fmt.Printf("Cantidad de clientes con correos de Costa Rica: %d\n", cantidad)

	// función clientesSugerenciasCorreos
	clientesModificados := clientesSugerenciasCorreos(&listaClientesNegocio)
	fmt.Println("Clientes con correos sugeridos:")
	fmt.Println(clientesModificados)

	//  función correosOrdenadosAlfabeticos
	correosOrdenados := correosOrdenadosAlfabeticos(&listaClientesNegocio)
	fmt.Println("Correos de clientes ordenados alfabéticamente:")
	for _, correo := range correosOrdenados {
		fmt.Println(correo)
	}
}
