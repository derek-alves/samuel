import 'package:medicament_app/data/model/medicament.dart';
import 'package:medicament_app/di/build_get_interaction_usecase.dart';
import 'package:medicament_app/presentation/interaction/cubit/interaction_cubit.dart';

InteractionCubit buildInteractionCubit(
    List<MedicamentModel> selectedMedicaments) {
  return InteractionCubit(
    getInteractionUsecase: buildGetInteractionUsecase(),
    selectedMedicaments: selectedMedicaments,
  );
}
