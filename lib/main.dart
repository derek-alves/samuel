import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicament_app/di/build_interaction_cubit.dart';
import 'package:medicament_app/di/build_search_cubit.dart';
import 'package:medicament_app/presentation/interaction/interaction_page.dart';
import 'package:medicament_app/presentation/medicament/selected_medicament_page.dart';
import 'package:medicament_app/presentation/search/search_page.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => buildSearchCubit(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: onGenerateRoute,
    );
  }
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.interactions:
      return MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: buildInteractionCubit(
            (settings.arguments as Map<String, dynamic>?)?['medicaments'] ?? [],
          ),
          child: const InteractionPage(),
        ),
      );

    case AppRoutes.selectedMedications:
      return MaterialPageRoute(
        builder: (context) => const SelectedMedicationsPage(),
      );

    case AppRoutes.search:
      return MaterialPageRoute(
        builder: (context) => const SearchPage(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('Rota desconhecida: ${settings.name}'),
          ),
        ),
      );
  }
}

class AppRoutes {
  static const String search = '/search';
  static const String interactions = '/interactions';
  static const String selectedMedications = '/';
}
