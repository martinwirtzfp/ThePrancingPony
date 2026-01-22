import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea_4_1_interfaces/models/product.dart';
import 'package:tarea_4_1_interfaces/viewmodels/ordersViewModel.dart';
import 'package:tarea_4_1_interfaces/views/select_products_page.dart';

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
                // Navigator.push para ir a elegir productos
                final Map<Product, int>? products = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectProductsPage(),
                  ),
                );

                // Verificar mounted antes de usar setState
                if (!mounted) return;

                // Si el usuario seleccionó productos, actualizar
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
                  // Navegación con pushNamed (ruta con nombre)
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
                      // Validaciones
                      final tableText = tableController.text.trim();
                      
                      if (tableText.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor, introduce un número de mesa'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

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

                      if (selectedProducts.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Añade al menos un producto'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // Crear el pedido y añadirlo al ViewModel
                      final viewModel = context.read<OrderViewModel>();
                      viewModel.createOrder(table);
                      
                      // Añadir cada producto al pedido
                      selectedProducts.forEach((product, quantity) {
                        viewModel.addProductToOrder(table, product, quantity);
                      });

                      // Obtener el pedido completo
                      final completedOrder = viewModel.getOrderByTable(table);

                      // Guardar: volver con el pedido creado
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
