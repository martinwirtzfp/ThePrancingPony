class Product {
  String name;
  double price;

  Product(this.name, this.price);

  // Sobrescribir el operador de igualdad
  // para comparar productos por nombre y precio
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          name == other.name &&
          price == other.price;

  @override
  int get hashCode => Object.hash(name, price);
}