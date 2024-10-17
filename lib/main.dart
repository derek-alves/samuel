import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicament_app/medicament/selected_medicament_page.dart';
import 'package:medicament_app/search/cubit/search_cubit.dart';
import 'package:medicament_app/search/search_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final single = SearchCubit();
    return MaterialApp(
      routes: {
        '/': (context) => BlocProvider.value(
              value: single,
              child: const SelectedMedicationsPage(),
            ),
        '/search': (context) => BlocProvider.value(
              value: single,
              child: const SearchPage(),
            ),
      },
    );
  }
}
