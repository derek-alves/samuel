import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicament_app/data/model/analysis_model.dart';
import 'package:medicament_app/data/model/medicament.dart';
import 'package:medicament_app/data/usecase/get_interaction_usecase.dart';
import 'package:medicament_app/data/util/result.dart';
import 'package:medicament_app/presentation/search/cubit/search_cubit.dart';

part 'interaction_state.dart';

class InteractionCubit extends Cubit<InteractionState> {
  InteractionCubit({
    required List<MedicamentModel> selectedMedicaments,
    required GetInteractionUsecase getInteractionUsecase,
  }) : super(InteractionState.initial()) {
    _getInteractionUsecase = getInteractionUsecase;
    _verifyInteractions(selectedMedicaments);
  }
  late final GetInteractionUsecase _getInteractionUsecase;

  void _verifyInteractions(List<MedicamentModel> medicaments) async {
    emit(state.copyWith(pageState: PageState.loading));

    final response = await _getInteractionUsecase.execute(medicaments);
    final interactions = response.getValueOrNull();

    if (interactions == null || interactions.medications.length <= 1) {
      emit(state.copyWith(pageState: PageState.error));
      return;
    }

    emit(
      state.copyWith(
        pageState: PageState.loaded,
        selectedMedicaments: medicaments,
        interactionAnalysis: interactions,
      ),
    );
  }
}
