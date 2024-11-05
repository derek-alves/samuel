// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'interaction_cubit.dart';

class InteractionState extends Equatable {
  const InteractionState({
    required this.pageState,
    required this.selectedMedicaments,
    required this.interactionAnalysis,
  });

  final PageState pageState;
  final List<MedicamentModel> selectedMedicaments;
  final List<AnalysisModel> interactionAnalysis;

  factory InteractionState.initial() {
    return const InteractionState(
      interactionAnalysis: [],
      pageState: PageState.initial,
      selectedMedicaments: [],
    );
  }

  @override
  List<Object?> get props => [
        pageState,
        selectedMedicaments,
        interactionAnalysis,
      ];

  InteractionState copyWith({
    PageState? pageState,
    List<MedicamentModel>? selectedMedicaments,
    List<AnalysisModel>? interactionAnalysis,
  }) {
    return InteractionState(
      pageState: pageState ?? this.pageState,
      selectedMedicaments: selectedMedicaments ?? this.selectedMedicaments,
      interactionAnalysis: interactionAnalysis ?? this.interactionAnalysis,
    );
  }
}
