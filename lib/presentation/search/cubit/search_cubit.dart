import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicament_app/data/model/medicament.dart';
import 'package:medicament_app/data/usecase/get_medicament_usecase.dart';
import 'package:medicament_app/data/util/result.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required GetMedicamentUsecase getMedicamentUsecase,
  }) : super(SearchState.initial()) {
    _getMedicamentUsecase = getMedicamentUsecase;
  }
  late final GetMedicamentUsecase _getMedicamentUsecase;

  void deleteMedicament(String id) {
    final selectedMedicamentNew = [...state.selectedMedicaments];
    selectedMedicamentNew.removeWhere((element) => element.id == id);
    emit(
      state.copyWith(
        selectedMedicaments: selectedMedicamentNew,
        pageState: selectedMedicamentNew.isEmpty
            ? PageState.initial
            : PageState.selectedItems,
      ),
    );
  }

  Future<void> searchMedicaments(String query) async {
    emit(state.copyWith(pageState: PageState.loading));

    final response = await _getMedicamentUsecase.execute(query);
    final medicaments = response.getValueOrNull();

    if (medicaments == null) {
      emit(state.copyWith(pageState: PageState.error));
      return;
    }
    if (medicaments.isEmpty) {
      emit(state.copyWith(pageState: PageState.empty));
      return;
    }

    emit(
      state.copyWith(
        pageState: PageState.loaded,
        medicaments: medicaments,
      ),
    );
  }

  void showSelectedItems() {
    emit(state.copyWith(pageState: PageState.selectedItems));
  }

  void toggleSelection(MedicamentModel medicament) {
    final selectedMedicamentsIds =
        List<String>.from(state.selectedMedicaments.map((e) => e.id));

    final selectedMedicamentNew = [...state.selectedMedicaments];
    if (selectedMedicamentsIds.contains(medicament.id)) {
      selectedMedicamentNew
          .removeWhere((element) => element.id == medicament.id);
    } else {
      selectedMedicamentNew.add(medicament);
    }
    emit(
      state.copyWith(
        selectedMedicaments: selectedMedicamentNew,
        pageState: selectedMedicamentNew.isEmpty
            ? PageState.initial
            : PageState.selectedItems,
      ),
    );
  }

  bool isMedicamentSelected(String id) {
    return state.selectedMedicaments.any((element) => element.id == id);
  }

  List<MedicamentModel> getSelectedMedicaments() {
    return state.selectedMedicaments;
  }

  void resetState() {
    emit(SearchState.initial());
  }
}
