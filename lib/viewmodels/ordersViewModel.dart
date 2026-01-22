import 'package:flutter/material.dart';
import 'package:tarea_4_1_interfaces/models/order.dart';
import 'package:tarea_4_1_interfaces/models/product.dart';

/// ViewModel que gestiona la lógica de negocio de los pedidos.
///
/// Implementa el patrón MVVM y extiende ChangeNotifier para notificar
/// a las vistas cuando hay cambios en los datos.
class OrderViewModel extends ChangeNotifier {
  List<Order> orders = [];

  /// Crea un nuevo pedido si no existe ya una mesa con ese número.
  void createOrder(int tableNumber) {
    if (!orders.any((order) => order.table == tableNumber)) {
      orders.add(Order(tableNumber, {}));
      notifyListeners();
    }
  }

  /// Elimina un pedido de la lista de pedidos activos.
  void deleteOrder(int tableNumber) {
    orders.removeWhere((order) => order.table == tableNumber);
    notifyListeners();
  }

  /// Añade un producto a una mesa específica.
  /// Si el producto ya existe, suma la cantidad.
  void addProductToOrder(int tableNumber, Product product, int quantity) {
    try {
      Order order = orders.firstWhere((o) => o.table == tableNumber);
      order.addProduct(product, quantity);
      notifyListeners();
    } catch (e) {
      print('Error: Mesa $tableNumber no encontrada');
    }
  }

  /// Elimina un producto de una mesa específica.
  void deleteProductFromOrder(int tableNumber, Product product) {
    try {
      Order order = orders.firstWhere((o) => o.table == tableNumber);
      order.deleteProduct(product);
      notifyListeners();
    } catch (e) {
      print('Error: Mesa $tableNumber no encontrada');
    }
  }

  /// Obtiene el importe total de una mesa. Retorna 0.0 si no existe.
  double getTableTotal(int tableNumber) {
    try {
      Order order = orders.firstWhere((o) => o.table == tableNumber);
      return order.total;
    } catch (e) {
      return 0.0;
    }
  }

  /// Obtiene el pedido completo de una mesa. Retorna null si no existe.
  Order? getOrderByTable(int tableNumber) {
    try {
      return orders.firstWhere((o) => o.table == tableNumber);
    } catch (e) {
      return null;
    }
  }

  /// Carga pedidos de ejemplo para demostración.
  void loadInitialOrders() {
    orders.addAll([
      Order(1, {Product('Cerveza', 2.5): 2, Product('Tapa', 4.0): 2}),
      Order(2, {Product('Café', 1.5): 1}),
      Order(3, {Product('Refresco', 2.0): 3, Product('Bocadillo', 5.0): 2}),
    ]);
    notifyListeners();
  }
}
