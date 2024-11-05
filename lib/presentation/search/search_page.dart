import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart'; // Usando Google Fonts
import 'package:medicament_app/data/model/medicament.dart';
import 'package:medicament_app/presentation/search/cubit/search_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Timer? _debounce;
  final Duration _debounceDuration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buscar Medicamento',
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                _onSearchChanged(query, searchCubit);
              },
              decoration: InputDecoration(
                labelText: 'Procurar medicamento',
                labelStyle: GoogleFonts.nunito(
                  fontSize: 18,
                  color: Colors.teal[300],
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.teal),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.teal),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.teal, width: 2),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state.pageState == PageState.loading) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.teal));
                } else if (state.pageState == PageState.empty) {
                  return _buildEmptyState();
                } else if (state.pageState == PageState.selectedItems ||
                    state.pageState == PageState.loaded) {
                  final medicaments = state.pageState == PageState.selectedItems
                      ? state.selectedMedicaments
                      : state.medicaments;

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: medicaments.length,
                    itemBuilder: (_, index) {
                      final medicament = medicaments[index];
                      final isSelected =
                          searchCubit.isMedicamentSelected(medicament.id);

                      return Card(
                        color: Colors.teal[50],
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            medicament.name,
                            style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal[800],
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                'Substância Ativa: ${medicament.activeSubstance}',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: Colors.teal[700],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Fabricante: ${medicament.manufacturer}',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: Colors.teal[700],
                                ),
                              ),
                            ],
                          ),
                          trailing: Icon(
                            isSelected
                                ? Icons.check_circle
                                : Icons.add_circle_outline,
                            color: isSelected ? Colors.teal : Colors.grey,
                          ),
                          onTap: () => _showBottomSheet(context, medicament),
                        ),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.teal[200],
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhum medicamento encontrado.',
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.teal[300],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tente buscar novamente usando outro termo.',
            style: GoogleFonts.nunito(
              fontSize: 16,
              color: Colors.teal[300],
            ),
          ),
        ],
      ),
    );
  }
}
