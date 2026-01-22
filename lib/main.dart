import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea_4_1_interfaces/viewmodels/ordersViewModel.dart';
import 'package:tarea_4_1_interfaces/views/home_page.dart';
import 'package:tarea_4_1_interfaces/views/summary_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider envuelve toda la app
    // Crea el ViewModel y lo hace accesible en todas las pantallas
    return ChangeNotifierProvider(
      create: (context) {
        // Crear el ViewModel
        final viewModel = OrderViewModel();
        // Cargar pedidos iniciales de ejemplo
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
        // Pantalla inicial
        home: const HomePage(),
        // Rutas con nombre (para navegación con pushNamed)
        routes: {
          '/summary': (context) => const SummaryPage(),
        },
      ),
    );
  }
}
