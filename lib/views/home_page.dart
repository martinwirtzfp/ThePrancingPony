import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea_4_1_interfaces/models/order.dart';
import 'package:tarea_4_1_interfaces/viewmodels/ordersViewModel.dart';
import 'package:tarea_4_1_interfaces/views/create_order_page.dart';

/// Pantalla principal que muestra la lista de pedidos activos.
///
/// Esta vista consume el [OrderViewModel] para mostrar todas las mesas
/// con pedidos activos y permite crear nuevos pedidos.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Pedidos del Bar'),
      ),
      // Consumer escucha los cambios del ViewModel y reconstruye cuando hay notificaciones
      body: Consumer<OrderViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.orders.isEmpty) {
            return const Center(
              child: Text(
                'No hay pedidos',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          // Lista de Cards con información de cada mesa
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: viewModel.orders.length,
            itemBuilder: (context, index) {
              final order = viewModel.orders[index];
              
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Text(
                      '${order.table}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    'Mesa ${order.table}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Productos: ${order.totalItems} - Total: ${order.total.toStringAsFixed(2)}€',
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Navegación imperativa con Navigator.push y espera del resultado
          final Order? newOrder = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateOrderPage(),
            ),
          );

          // Verificar que el widget sigue montado antes de usar el context
          if (!context.mounted) return;

          // Mostrar confirmación si se creó el pedido
          if (newOrder != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Pedido mesa ${newOrder.table} creado'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Pedido'),
      ),
    );
  }
}
