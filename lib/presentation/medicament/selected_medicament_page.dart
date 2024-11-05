import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart'; // Para fontes personalizadas
import 'package:medicament_app/data/model/medicament.dart';
import 'package:medicament_app/main.dart';
import 'package:medicament_app/presentation/search/cubit/search_cubit.dart';

class SelectedMedicationsPage extends StatelessWidget {
  const SelectedMedicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selecione medicamentos',
          style: GoogleFonts.nunito(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
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
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons
                                  .medication, // Ícone representativo de saúde/medicamento
                              size: 80,
                              color: Colors.teal[200],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Nenhum medicamento selecionado',
                              style: GoogleFonts.nunito(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child: Text(
                                'Selecione medicamentos para verificar a compatibilidade entre eles e descobrir possíveis interações.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  color: Colors.teal[600],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.search,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF009688),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              child: Text(
                                'Adicionar Medicamento',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: selectedMedications.length,
                        itemBuilder: (context, index) {
                          final medicament = selectedMedications[index];
                          return MedicamentCard(
                            medicament: medicament,
                            onRemove: () {
                              context.read<SearchCubit>().deleteMedicament(
                                    medicament.id,
                                  );
                            },
                          );
                        },
                      ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocSelector<SearchCubit, SearchState, List<MedicamentModel>>(
                  selector: (state) {
                    return state.selectedMedicaments;
                  },
                  builder: (context, selectedMedicaments) {
                    return Expanded(
                      flex: 3,
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
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Verificar Interações',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.search,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Icon(Icons.search, color: Colors.teal),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MedicamentCard extends StatelessWidget {
  final MedicamentModel medicament;
  final VoidCallback onRemove;

  const MedicamentCard({
    super.key,
    required this.medicament,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    medicament.name,
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onRemove,
                  child: Text(
                    'Remover',
                    style: GoogleFonts.nunito(
                      color: Colors.redAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: Colors.teal[900],
                ),
                children: [
                  const TextSpan(
                    text: 'Substância ativa: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: medicament.activeSubstance),
                ],
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: Colors.teal[900],
                ),
                children: [
                  const TextSpan(
                    text: 'Fabricante: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: medicament.manufacturer),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: medicament.therapeuticClasses
                  .map((therapeuticClass) => Chip(
                        label: Text(
                          therapeuticClass,
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.teal,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
