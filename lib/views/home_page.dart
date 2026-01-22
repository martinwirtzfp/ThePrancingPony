import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea_4_1_interfaces/models/order.dart';
import 'package:tarea_4_1_interfaces/viewmodels/ordersViewModel.dart';
import 'package:tarea_4_1_interfaces/views/create_order_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Pedidos del Bar'),
      ),
      body: Consumer<OrderViewModel>(
        builder: (context, viewModel, child) {
          // Si no hay pedidos, mostrar mensaje
          if (viewModel.orders.isEmpty) {
            return const Center(
              child: Text(
                'No hay pedidos',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          // Si hay pedidos, mostrar lista
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
          // Navegación imperativa con Navigator.push
          final Order? newOrder = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateOrderPage(),
            ),
          );

          // Verificar mounted antes de usar context
          if (!context.mounted) return;

          // Si el usuario guardó el pedido, mostrar confirmación
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
