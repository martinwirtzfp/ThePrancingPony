# Manual de Usuario - The Prancing Pony

**Versión:** 1.0  
**Fecha:** 22 de enero de 2026  
**Desarrollado por:** Martín Sánchez Novo  
**Contacto:** martin.sanchez@fernandowirtz.com

---

## Índice

1. [Introducción](#introducción)
2. [Primeros pasos](#primeros-pasos)
3. [Funcionalidades principales](#funcionalidades-principales)
   - [Visualizar pedidos activos](#visualizar-pedidos-activos)
   - [Crear nuevo pedido](#crear-nuevo-pedido)
   - [Seleccionar productos](#seleccionar-productos)
   - [Ver resumen del pedido](#ver-resumen-del-pedido)
4. [Preguntas frecuentes](#preguntas-frecuentes)
5. [Contacto y soporte](#contacto-y-soporte)

---

## Introducción

The Prancing Pony es una aplicación de gestión de pedidos diseñada para facilitar el trabajo en bares y restaurantes. Permite crear y gestionar pedidos de manera rápida e intuitiva, asignándolos a diferentes mesas y calculando automáticamente los totales.

### Requisitos del sistema

- Dispositivo Android 5.0 o superior
- Dispositivo iOS 12.0 o superior
- Conexión a internet no requerida (la aplicación funciona offline)

### Características principales

- Gestión de pedidos por mesa
- Catálogo de productos con precios
- Cálculo automático de totales
- Interfaz intuitiva y fácil de usar
- Validaciones para evitar errores

---

<div style="page-break-after: always;"></div>

Al iniciar la aplicación por primera vez, encontrarás tres pedidos de ejemplo precargados en las mesas 1, 2 y 3. Estos pedidos sirven para familiarizarte con la interfaz y pueden ser utilizados como referencia.

### Pantalla principal

La pantalla principal muestra todos los pedidos activos en formato de tarjetas. Cada tarjeta incluye:

- Número de mesa
- Cantidad de productos en el pedido
- Importe total del pedido

Para crear un nuevo pedido, pulsa el botón flotante "Nuevo Pedido" ubicado en la esquina inferior derecha.

---

## Funcionalidades principales

### Visualizar pedidos activos

En la pantalla principal puedes ver todas las mesas con pedidos activos. Cada pedido muestra:

- **Número de mesa:** Identificado con un círculo naranja
- **Resumen:** Cantidad de productos y total a pagar

Si no hay pedidos activos, aparecerá el mensaje "No hay pedidos".

### Crear nuevo pedido

Para crear un nuevo pedido:

1. Pulsa el botón "Nuevo Pedido" en la pantalla principal
2. Introduce el número de mesa en el campo correspondiente
3. Pulsa "Añadir Productos" para seleccionar los artículos
4. Una vez seleccionados los productos, pulsa "Guardar Pedido"

**Validaciones:**
- El número de mesa debe ser mayor que 0
- No se pueden crear dos pedidos para la misma mesa
- Debe seleccionarse al menos un producto

### Seleccionar productos

En la pantalla de selección de productos:

1. Visualiza el menú completo del bar con precios
2. Usa los botones **+** y **-** para ajustar las cantidades
3. El total se actualiza automáticamente
4. Pulsa "Confirmar Selección" para volver al pedido

**Productos disponibles:**
- Cerveza (2,50€)
- Café (1,50€)
- Refresco (2,00€)
- Tapa (4,00€)
- Bocadillo (5,00€)
- Vino (3,50€)
- Agua (1,00€)
- Patatas Fritas (3,00€)

### Ver resumen del pedido

Antes de guardar un pedido, puedes visualizar un resumen detallado:

1. En la pantalla de creación, pulsa "Ver Resumen"
2. Revisa todos los productos, cantidades y precios
3. Verifica el total del pedido
4. Pulsa "Volver a Edición" si necesitas hacer cambios

El resumen muestra:
- Número de mesa
- Lista completa de productos con cantidades
- Precio unitario de cada producto
- Subtotal por producto
- Total general del pedido

---

## Preguntas frecuentes

### ¿Puedo modificar un pedido ya creado?

Actualmente, la aplicación no permite modificar pedidos existentes. Esta funcionalidad estará disponible en futuras versiones.

En la versión actual no está disponible la opción de editar pedidos. Tendrás que crear uno nuevo si necesitas hacer cambios.

### ¿Qué pasa si intento crear un pedido para una mesa que ya tiene pedido?

El sistema te avisará con un mensaje y no te dejará crear el pedido duplicado.

### ¿Los datos se guardan?

Los pedidos se mantienen mientras la app está abierta. Si cierras la aplicación, se perderán. Estoy trabajando para añadir guardado permanente en futuras versiones.

### ¿Necesito internet?

No, la app funciona completamente sin conexión.

### ¿Cómo cancelo si me equivoco?

Puedes pulsar "Cancelar" en cualquier momento para volver atrás sin guardar nada.

---

### Información de contacto

Si tienes dudas, sugerencias o necesitas asistencia técnica, puedes contactarnos a través de:

**Email:** martin.sanchez@fernandowirtz.com  
**Desarrollador:** Martín Sánchez Novo  

### Reportar un problema

Para reportar errores o problemas técnicos:

1. Describe detalladamente el problema encontrado
2. Indica los pasos para reproducir el error
3. Incluye capturas de pantalla si es posible
Si tienes dudas o encuentras algún problema, puedes contactarme:

**Email:** martin.sanchez@fernandowirtz.com

Para reportar errores, por favor incluye:
- Descripción del problema
- Pasos para reproducirlo
- Capturas de pantalla si es posible

Cualquier sugerencia de mejora es bienvenida. Puedes seguir el desarrollo del proyecto en:

**GitHub:** https://github.com/martinwirtzfp/ThePrancingPony
