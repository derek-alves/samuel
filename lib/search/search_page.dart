import 'dart:async'; // Import to use Timer

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicament_app/model/medicament.dart';
import 'package:medicament_app/search/cubit/search_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Timer? _debounce;

  // Duration to wait after the user stops typing before making the search call
  final Duration _debounceDuration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Search Medicament')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                _onSearchChanged(query, searchCubit);
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state.pageState == SearchPageState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.pageState == SearchPageState.empty) {
                  return const Center(child: Text('No medicaments found.'));
                } else if (state.pageState == SearchPageState.selectedItems) {
                  return ListView.builder(
                    itemCount: state.selectedMedicaments.length,
                    itemBuilder: (_, index) {
                      final medicament = state.selectedMedicaments[index];
                      return ListTile(
                        title: Text(medicament.name),
                        trailing: const Icon(Icons.check_box),
                        onTap: () => _showBottomSheet(context, medicament),
                      );
                    },
                  );
                } else if (state.pageState == SearchPageState.loaded) {
                  return ListView.builder(
                    itemCount: state.medicaments.length,
                    itemBuilder: (_, index) {
                      final medicament = state.medicaments[index];
                      return ListTile(
                        title: Text(medicament.name),
                        trailing: Icon(
                            searchCubit.isMedicamentSelected(medicament.id)
                                ? Icons.check_box
                                : Icons.check_box_outline_blank),
                        onTap: () => _showBottomSheet(context, medicament),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  // Debounce search input to delay search execution
  void _onSearchChanged(String query, SearchCubit searchCubit) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    if (query.isEmpty) {
      searchCubit.showSelectedItems();
      return;
    }
    _debounce = Timer(_debounceDuration, () {
      searchCubit.searchMedicaments(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _showBottomSheet(BuildContext context, MedicamentModel medicament) {
    context.read<SearchCubit>().toggleSelection(medicament);
  }
}
