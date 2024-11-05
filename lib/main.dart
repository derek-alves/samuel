import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicament_app/di/build_interaction_cubit.dart';
import 'package:medicament_app/di/build_search_cubit.dart';
import 'package:medicament_app/presentation/interaction/interaction_page.dart';
import 'package:medicament_app/presentation/medicament/selected_medicament_page.dart';
import 'package:medicament_app/presentation/search/search_page.dart';
import 'package:medicament_app/presentation/splash/splash_page.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => buildSearchCubit(),
    child: const MainApp(),
  ));
}

Route createPageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0); // Começa de baixo
      const end = Offset.zero; // Termina no centro
      const curve = Curves.fastOutSlowIn; // Curva mais rápida

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var fadeTween = Tween<double>(begin: 0.0, end: 1.0);

      return SlideTransition(
        position: animation.drive(tween),
        child: FadeTransition(
          opacity: animation.drive(fadeTween),
          child: child,
        ),
      );
    },
    transitionDuration:
        const Duration(milliseconds: 400), // Duração mais rápida
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: AppRoutes.splash,
      onGenerateRoute: onGenerateRoute,
    );
  }
}

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case AppRoutes.interactions:
      return MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: buildInteractionCubit(
            (settings.arguments as Map<String, dynamic>?)?['medicaments'] ?? [],
          ),
          child: const InteractionAnalysisPage(),
        ),
      );

    case AppRoutes.selectedMedications:
      return createPageRoute(const SelectedMedicationsPage());
    case AppRoutes.search:
      return createPageRoute(const SearchPage());

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
  static const String splash = '/';
  static const String search = '/search';
  static const String interactions = '/interactions';
  static const String selectedMedications = '/selected_medications';
}
