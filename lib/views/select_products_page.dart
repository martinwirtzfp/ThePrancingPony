import 'package:flutter/material.dart';
import 'package:tarea_4_1_interfaces/models/product.dart';

class SelectProductsPage extends StatefulWidget {
  const SelectProductsPage({super.key});

  @override
  State<SelectProductsPage> createState() => _SelectProductsPageState();
}

class _SelectProductsPageState extends State<SelectProductsPage> {
  // Carta del bar (al menos 6 productos)
  final List<Product> menuItems = [
    Product('Cerveza', 2.50),
    Product('Café', 1.50),
    Product('Refresco', 2.00),
    Product('Tapa', 4.00),
    Product('Bocadillo', 5.00),
    Product('Vino', 3.50),
    Product('Agua', 1.00),
    Product('Patatas Fritas', 3.00),
  ];

  // Map para guardar las cantidades seleccionadas: {Product: cantidad}
  final Map<Product, int> selectedItems = {};

  double calculateTotal() {
    double total = 0.0;
    selectedItems.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }

  int countProducts() {
    int count = 0;
    selectedItems.forEach((product, quantity) {
      count += quantity;
    });
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elegir Productos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Lista de productos
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final product = menuItems[index];
                final quantity = selectedItems[product] ?? 0;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Icono del producto
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.restaurant,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Nombre y precio
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${product.price.toStringAsFixed(2)}€',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Controles de cantidad
                        Row(
                          children: [
                            // Botón -
                            IconButton(
                              onPressed: quantity > 0
                                  ? () {
                                      setState(() {
                                        if (quantity == 1) {
                                          selectedItems.remove(product);
                                        } else {
                                          selectedItems[product] = quantity - 1;
                                        }
                                      });
                                    }
                                  : null,
                              icon: const Icon(Icons.remove_circle_outline),
                              color: Colors.red,
                            ),

                            // Cantidad
                            Container(
                              width: 40,
                              alignment: Alignment.center,
                              child: Text(
                                '$quantity',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // Botón +
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedItems[product] = quantity + 1;
                                });
                              },
                              icon: const Icon(Icons.add_circle_outline),
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Botones inferiores
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Resumen de selección
                if (selectedItems.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: ${calculateTotal().toStringAsFixed(2)}€',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${countProducts()} productos',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),

                // Botones
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Cancelar: volver sin datos
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Text('Cancelar'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: selectedItems.isEmpty
                            ? null
                            : () {
                                // Confirmar: volver con los productos seleccionados
                                Navigator.pop(context, selectedItems);
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Confirmar Selección'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
