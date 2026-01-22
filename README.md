# The Prancing Pony

Aplicación de gestión de pedidos para bar/restaurante desarrollada en Flutter.

## Descripción

Aplicación móvil que permite gestionar los pedidos de las mesas en un bar o restaurante. Permite crear pedidos por mesa, añadir productos desde un menú predefinido y visualizar resúmenes detallados de cada comanda.

## Tecnologías Utilizadas

- Flutter SDK 3.9.2
- Dart
- Provider 6.1.5+1 (gestión de estado)
- Material Design 3

## Características Principales

### Funcionalidades
- Gestión de pedidos por número de mesa
- Selección de productos del menú (8 productos disponibles)
- Control de cantidades con botones de incremento/decremento
- Cálculo automático de subtotales y totales
- Vista de resumen detallada del pedido
- Validaciones de formulario
- Datos de ejemplo precargados

### Arquitectura
- Patrón MVVM (Model-View-ViewModel)
- Gestión de estado reactiva con Provider
- Navegación mediante Navigator (push, pushNamed, pop)
- Separación de responsabilidades en capas

## Estructura del Proyecto

```
lib/
├── main.dart                      # Punto de entrada de la aplicación
├── models/
│   ├── product.dart               # Modelo de producto
│   └── order.dart                 # Modelo de pedido
├── viewmodels/
│   └── ordersViewModel.dart       # Lógica de negocio y gestión de estado
└── views/
    ├── home_page.dart             # Pantalla principal con lista de pedidos
    ├── create_order_page.dart     # Creación de nuevo pedido
    ├── select_products_page.dart  # Selección de productos del menú
    └── summary_page.dart          # Resumen detallado del pedido
```

## Instalación

1. Clonar el repositorio
```bash
git clone https://github.com/martinwirtzfp/ThePrancingPony.git
cd ThePrancingPony
```

2. Instalar dependencias
```bash
flutter pub get
```

3. Ejecutar la aplicación
```bash
flutter run
```

## Requisitos

- Flutter SDK 3.9.2 o superior
- Dart SDK 3.9.2 o superior

## Autor

Martín Sánchez Novo
