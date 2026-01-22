import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea_4_1_interfaces/models/product.dart';
import 'package:tarea_4_1_interfaces/viewmodels/ordersViewModel.dart';
import 'package:tarea_4_1_interfaces/views/select_products_page.dart';

/// Pantalla para crear un nuevo pedido.
///
/// Permite al usuario introducir el número de mesa, seleccionar productos
/// del menú y ver un resumen antes de guardar el pedido.
class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final TextEditingController tableController = TextEditingController();
  Map<Product, int> selectedProducts = {};

  @override
  void dispose() {
    tableController.dispose();
    super.dispose();
  }

  /// Calcula el total del pedido actual sumando el precio de todos los productos.
  double calculateTotal() {
    double total = 0.0;
    selectedProducts.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Pedido'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de texto para la mesa
            TextField(
              controller: tableController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Número de Mesa',
                hintText: 'Ej: 1, 2, 3...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.table_restaurant),
              ),
            ),
            const SizedBox(height: 20),

            // Botón para elegir productos
            ElevatedButton.icon(
              onPressed: () async {
                // Navegar a la pantalla de selección de productos y esperar resultado
                final Map<Product, int>? products = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectProductsPage(),
                  ),
                );

                if (!mounted) return;

                // Actualizar los productos seleccionados con los devueltos por la pantalla
                if (products != null) {
                  setState(() {
                    selectedProducts = products;
                  });
                }
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Añadir Productos'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 20),

            // Resumen provisional
            const Text(
              'Resumen provisional:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: selectedProducts.isEmpty
                  ? Center(
                      child: Text(
                        'No hay productos seleccionados',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    )
                  : Card(
                      elevation: 2,
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          ...selectedProducts.entries.map((entry) {
                            final product = entry.key;
                            final quantity = entry.value;
                            final subtotal = product.price * quantity;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${product.name} x$quantity',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    '${subtotal.toStringAsFixed(2)}€',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const Divider(thickness: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'TOTAL:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${calculateTotal().toStringAsFixed(2)}€',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),

            // Botón para ver resumen (con pushNamed)
            if (selectedProducts.isNotEmpty)
              ElevatedButton.icon(
                onPressed: () {
                  // Navegación mediante ruta con nombre, pasando argumentos
                  Navigator.pushNamed(
                    context,
                    '/summary',
                    arguments: {
                      'table': tableController.text,
                      'products': selectedProducts,
                    },
                  );
                },
                icon: const Icon(Icons.visibility),
                label: const Text('Ver Resumen'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            const SizedBox(height: 10),

            // Botones Guardar y Cancelar
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
                    onPressed: () {
                      final tableText = tableController.text.trim();
                      
                      // Validar que se haya introducido un número de mesa
                      if (tableText.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor, introduce un número de mesa'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // Validar que el número de mesa sea válido y mayor que 0
                      final table = int.tryParse(tableText);
                      if (table == null || table <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('El número de mesa debe ser válido'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // Validar que se hayan seleccionado productos
                      if (selectedProducts.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Añade al menos un producto'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // Obtener el ViewModel y crear el pedido
                      final viewModel = context.read<OrderViewModel>();
                      viewModel.createOrder(table);
                      
                      // Añadir cada producto seleccionado al pedido creado
                      selectedProducts.forEach((product, quantity) {
                        viewModel.addProductToOrder(table, product, quantity);
                      });

                      final completedOrder = viewModel.getOrderByTable(table);

                      // Volver a la pantalla anterior devolviendo el pedido creado
                      Navigator.pop(context, completedOrder);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Guardar Pedido'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
