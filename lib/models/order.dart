import 'package:tarea_4_1_interfaces/models/product.dart';

class Order {
  final int table;
  Map<Product, int> products;

  Order(this.table, this.products);

  // Añadir un producto
  void addProduct(Product product, int quantity) {
    if (products.containsKey(product)) {
      products[product] = products[product]! + quantity;
    } else {
      products[product] = quantity;
    }
  }

  // Eliminar un producto
  void deleteProduct(Product product) {
    if (products.containsKey(product)){
      products.remove(product);
    } 
  }
  
  // Obtener el importe total
  double get total {
    double sum = 0.0;
    products.forEach((product, quantity){
      sum += product.price * quantity;
    });
    return sum;
  }

  // Obtener cantidad total de productos
  int get totalItems {
    int count = 0;
    products.forEach((product, quantity) {
      count += quantity;
    });
    return count;
  }
}