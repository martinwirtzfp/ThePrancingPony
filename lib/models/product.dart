/// Representa un producto del menú del bar.
///
/// Implementa comparación por valor para poder ser usado como clave en Maps.
class Product {
  String name;
  double price;

  Product(this.name, this.price);

  /// Sobrescribe el operador de igualdad para comparar productos por valor.
  ///
  /// Dos productos son iguales si tienen el mismo nombre y precio.
  /// Esto permite usar Product como clave en Map<Product, int>.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          name == other.name &&
          price == other.price;

  /// Genera un hash code basado en el nombre y precio del producto.
  @override
  int get hashCode => Object.hash(name, price);
}