import 'package:flutter/material.dart';
import 'package:tarea_4_1_interfaces/models/order.dart';
import 'package:tarea_4_1_interfaces/models/product.dart';

class OrderViewModel extends ChangeNotifier {
  // Lista de todos los pedidos (todas las mesas)
  List<Order> orders = [];

  // Crear un nuevo pedido (abrir mesa)
  void createOrder(int tableNumber) {
    // Verificar que la mesa no exista ya
    if (!orders.any((order) => order.table == tableNumber)) {
      orders.add(Order(tableNumber, {}));
      notifyListeners();
    }
  }

  // Eliminar un pedido (cerrar mesa)
  void deleteOrder(int tableNumber) {
    orders.removeWhere((order) => order.table == tableNumber);
    notifyListeners();
  }

  // Añadir producto a una mesa específica
  void addProductToOrder(int tableNumber, Product product, int quantity) {
    try {
      Order order = orders.firstWhere((o) => o.table == tableNumber);
      order.addProduct(product, quantity); //método de order
      notifyListeners();
    } catch (e) {
      print('Error: Mesa $tableNumber no encontrada');
    }
  }

  // Eliminar producto de una mesa
  void deleteProductFromOrder(int tableNumber, Product product) {
    try {
      Order order = orders.firstWhere((o) => o.table == tableNumber);
      order.deleteProduct(product); //método de order
      notifyListeners();
    } catch (e) {
      print('Error: Mesa $tableNumber no encontrada');
    }
  }

  // Obtener el importe total de una mesa
  double getTableTotal(int tableNumber) {
    try {
      Order order = orders.firstWhere((o) => o.table == tableNumber);
      return order.total; //método de order
    } catch (e) {
      return 0.0;
    }
  }

  // Obtener el pedido de una mesa
  Order? getOrderByTable(int tableNumber) {
    try {
      return orders.firstWhere((o) => o.table == tableNumber);
    } catch (e) {
      return null;
    }
  }

  // Cargar pedidos de iniciales
  void loadInitialOrders() {
    orders.addAll([
      Order(1, {Product('Cerveza', 2.5): 2, Product('Tapa', 4.0): 2}),
      Order(2, {Product('Café', 1.5): 1}),
      Order(3, {Product('Refresco', 2.0): 3, Product('Bocadillo', 5.0): 2}),
    ]);
    notifyListeners();
  }
}
