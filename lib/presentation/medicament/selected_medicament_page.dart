import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicament_app/data/model/medicament.dart';
import 'package:medicament_app/main.dart';
import 'package:medicament_app/presentation/search/cubit/search_cubit.dart';

class SelectedMedicationsPage extends StatelessWidget {
  const SelectedMedicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Medications'),
      ),
      body: Column(
        children: [
          BlocSelector<SearchCubit, SearchState, List<MedicamentModel>>(
            selector: (state) {
              return state.selectedMedicaments;
            },
            builder: (context, selectedMedications) {
              return Expanded(
                child: selectedMedications.isEmpty
                    ? const Center(child: Text('No medications selected.'))
                    : ListView.builder(
                        itemCount: selectedMedications.length,
                        itemBuilder: (context, index) {
                          final medicament = selectedMedications[index];
                          return Card(
                            margin: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(medicament.name),
                            ),
                          );
                        },
                      ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocSelector<SearchCubit, SearchState, List<MedicamentModel>>(
                  selector: (state) {
                    return state.selectedMedicaments;
                  },
                  builder: (context, selectedMedicaments) {
                    return SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: selectedMedicaments.length > 1
                            ? () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.interactions,
                                  arguments: {
                                    'medicaments': selectedMedicaments,
                                  },
                                );
                              }
                            : null, // Disable the button if only one or no medication is selected
                        child: const Text('Apply'),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.search,
                      ); // Navigate back to the search page
                    },
                    child: const Text('Search'),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
