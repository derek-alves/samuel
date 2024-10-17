import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medicament_app/model/medicament.dart';

part 'search_state.dart';

final List<MedicamentModel> _fakeMedicaments = [
  MedicamentModel(id: '1', name: 'Aspirin'),
  MedicamentModel(id: '2', name: 'Ibuprofen'),
  MedicamentModel(id: '3', name: 'Paracetamol'),
];

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState.initial());

  Future<void> searchMedicaments(String query) async {
    emit(state.copyWith(pageState: SearchPageState.loading));

    await Future.delayed(const Duration(seconds: 2));

    final results = _fakeMedicaments
        .where((medicament) =>
            medicament.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      emit(state.copyWith(pageState: SearchPageState.empty));
    } else {
      emit(
        state.copyWith(
          pageState: SearchPageState.loaded,
          medicaments: results,
        ),
      );
    }
  }

  void showSelectedItems() {
    emit(state.copyWith(pageState: SearchPageState.selectedItems));
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
            ? SearchPageState.initial
            : SearchPageState.selectedItems,        
      ),
    );
  }

  bool isMedicamentSelected(String id) {
    return state.selectedMedicaments.any((element) => element.id == id);
  }

  List<MedicamentModel> getSelectedMedicaments() {
    return state.selectedMedicaments;
  }
}
