import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicament_app/data/model/medicament.dart';
import 'package:medicament_app/main.dart';
import 'package:medicament_app/presentation/interaction/cubit/interaction_cubit.dart';
import 'package:medicament_app/presentation/search/cubit/search_cubit.dart';

class InteractionAnalysisPage extends StatelessWidget {
  const InteractionAnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Análise de Compatibilidade',
          style: GoogleFonts.nunito(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<InteractionCubit, InteractionState>(
                builder: (context, state) {
                  if (state.pageState == PageState.loading) {
                    return _buildLoadingState();
                  } else if (state.pageState == PageState.loading) {
                    return _buildErrorState(context);
                  } else if (state.pageState == PageState.loaded) {
                    final analysisData = state.interactionAnalysis;
                    return ListView.builder(
                      itemCount: analysisData.length,
                      itemBuilder: (context, index) {
                        final analysis = analysisData[index];
                        final medications = analysis.medications;
                        final interaction = analysis.interaction;
                        final riskLevel = interaction.riskLevel;
                        final analysisText = interaction.analysis;

                        return AnalysisCard(
                            medications: medications,
                            riskLevel: riskLevel,
                            analysisText: analysisText);
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<SearchCubit>().resetState();
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.selectedMedications,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Nova análise',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Voltar',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.teal),
          const SizedBox(height: 16),
          Text(
            'Carregando análises...',
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.teal[300],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.redAccent,
            size: 80,
          ),
          const SizedBox(height: 16),
          Text(
            'Erro ao carregar análises',
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Não foi possível obter as análises de compatibilidade.\nPor favor, tente novamente.',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              fontSize: 16,
              color: Colors.teal[300],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // context.read<InteractionCubit>().reloadAnalysis();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Tentar Novamente',
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnalysisCard extends StatelessWidget {
  const AnalysisCard({
    super.key,
    required this.medications,
    required this.riskLevel,
    required this.analysisText,
  });

  final List<MedicamentModel> medications;
  final int riskLevel;
  final String analysisText;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent, // Remove a linha entre os itens
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.all(16.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Organização vertical para comparação
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Medicamento 1
                  Text(
                    medications[0].name,
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                    ),
                  ),
                  Text(
                    medications[0].activeSubstance,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Colors.teal[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Indicador de comparação
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Colors.teal,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Comparado com',
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal[800],
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: Colors.teal,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Medicamento 2
                  Text(
                    medications[1].name,
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                    ),
                  ),
                  Text(
                    medications[1].activeSubstance,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Colors.teal[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          subtitle: Align(
            alignment: Alignment
                .centerLeft, // Alinhamento para manter o container no tamanho do texto
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: riskLevel == 0 ? Colors.green[100] : Colors.red[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                riskLevel == 0 ? 'Compatível' : 'Incompatível',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: riskLevel == 0 ? Colors.green[800] : Colors.red[800],
                ),
              ),
            ),
          ),
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Exibe a análise detalhada
                  Text(
                    'Análise:',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    analysisText,
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      color: Colors.teal[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Detalhes dos Medicamentos
                  Text(
                    'Detalhes dos Medicamentos:',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Scroll horizontal para medicamentos
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: medications.map((med) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 12.0), // Espaçamento entre cards
                          child: Container(
                            width: 220, // Define a largura do card
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.teal[50],
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  med.name,
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal[800],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Substância ativa: ${med.activeSubstance}',
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Fabricante: ${med.manufacturer}',
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 4.0,
                                  children:
                                      med.therapeuticClasses.map((className) {
                                    return Chip(
                                      label: Text(
                                        className,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      backgroundColor: Colors.teal,
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
