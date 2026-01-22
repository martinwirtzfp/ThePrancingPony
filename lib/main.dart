import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea_4_1_interfaces/viewmodels/ordersViewModel.dart';
import 'package:tarea_4_1_interfaces/views/home_page.dart';
import 'package:tarea_4_1_interfaces/views/summary_page.dart';

/// Punto de entrada de la aplicación.
void main() {
  runApp(const MyApp());
}

/// Widget raíz de la aplicación The Prancing Pony.
///
/// Configura el Provider para la gestión de estado global y define
/// las rutas de navegación de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider envuelve toda la app para proporcionar
    // el ViewModel a todas las pantallas mediante el patrón Provider
    return ChangeNotifierProvider(
      create: (context) {
        final viewModel = OrderViewModel();
        // Cargar pedidos de ejemplo al iniciar la aplicación
        viewModel.loadInitialOrders();
        return viewModel;
      },
      child: MaterialApp(
        title: 'Gestion pedidos Bar',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        home: const HomePage(),
        // Rutas con nombre para navegación mediante pushNamed
        routes: {
          '/summary': (context) => const SummaryPage(),
        },
      ),
    );
  }
}
