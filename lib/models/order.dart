import 'package:tarea_4_1_interfaces/models/product.dart';

/// Representa un pedido de una mesa en el bar.
///
/// Cada pedido contiene un Map de productos donde la clave es el producto
/// y el valor es la cantidad pedida.
class Order {
  final int table;
  Map<Product, int> products;

  Order(this.table, this.products);

  /// Añade un producto al pedido con la cantidad especificada.
  ///
  /// Si el producto ya existe en el pedido, suma la cantidad nueva
  /// a la cantidad existente. Si no existe, lo añade como nuevo producto.
  void addProduct(Product product, int quantity) {
    if (products.containsKey(product)) {
      products[product] = products[product]! + quantity;
    } else {
      products[product] = quantity;
    }
  }

  /// Elimina un producto del pedido.
  void deleteProduct(Product product) {
    if (products.containsKey(product)){
      products.remove(product);
    } 
  }
  
  /// Calcula el importe total del pedido.
  double get total {
    double sum = 0.0;
    products.forEach((product, quantity){
      sum += product.price * quantity;
    });
    return sum;
  }

  /// Devuelve la cantidad total de productos en el pedido.
  int get totalItems {
    int count = 0;
    products.forEach((product, quantity) {
      count += quantity;
    });
    return count;
  }
}