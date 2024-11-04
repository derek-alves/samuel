import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicament_app/data/model/interaction_result.dart';
import 'package:medicament_app/main.dart';
import 'package:medicament_app/presentation/interaction/cubit/interaction_cubit.dart';
import 'package:medicament_app/presentation/search/cubit/search_cubit.dart';

class InteractionPage extends StatelessWidget {
  const InteractionPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificação de Interações'),
      ),
      bottomNavigationBar: BlocBuilder<InteractionCubit, InteractionState>(
        builder: (context, state) {
          if (state.pageState == PageState.loading) {
            return const SizedBox.shrink();
          }
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<SearchCubit>().resetState();
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.selectedMedications,
                    );
                  },
                  child: const Text('Nova combinacao'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child: const Text('Voltar'),
                ),
              ],
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: BlocBuilder<InteractionCubit, InteractionState>(
          builder: (context, state) {
            switch (state.pageState) {
              case PageState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case PageState.error:
                return const Center(
                  child: Text(
                    'Ocorreu um erro ao verificar as interações. Tente novamente.',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                );

              case PageState.loaded:
                if (state.interactionAnalysis.isEmpty) {
                  return const Center(
                    child: Text(
                      'Não foi possível verificar as interações.',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  );
                }

                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 24),
                  itemCount: state.interactionAnalysis.length,
                  itemBuilder: (context, index) {
                    final interaction = state.interactionAnalysis[index];
                    return InteractionCard(interaction: interaction);
                  },
                );

              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }
}

class InteractionCard extends StatelessWidget {
  const InteractionCard({required this.interaction, super.key});
  final InteractionResult interaction;

  @override
  Widget build(BuildContext context) {
    Widget body = const SizedBox.shrink();
    if (interaction.success) {
      body = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            const Text(
              'Interação Compatível!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              interaction.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    } else {
      body = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning, color: Colors.orange, size: 60),
            const SizedBox(height: 16),
            const Text(
              'Interações Não Compatíveis!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              interaction.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: body,
    );
  }
}
