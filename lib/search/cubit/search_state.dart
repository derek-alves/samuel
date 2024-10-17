// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

class SearchState extends Equatable {
  final List<MedicamentModel> medicaments;
  final List<MedicamentModel> selectedMedicaments;
  final SearchPageState pageState;

  const SearchState({
    required this.medicaments,
    required this.pageState,
    required this.selectedMedicaments,
  });

  factory SearchState.initial() {
    return const SearchState(
      selectedMedicaments: [],
      medicaments: [],
      pageState: SearchPageState.initial,
    );
  }

  SearchState copyWith({
    List<MedicamentModel>? medicaments,
    List<MedicamentModel>? selectedMedicaments,
    SearchPageState? pageState,
  }) {
    return SearchState(
      selectedMedicaments: selectedMedicaments ?? this.selectedMedicaments,
      medicaments: medicaments ?? this.medicaments,
      pageState: pageState ?? this.pageState,
    );
  }

  @override
  List<Object> get props => [
        medicaments,
        selectedMedicaments,
        pageState,
      ];
}

enum SearchPageState {
  initial,
  empty,
  loading,
  loaded,
  selectedItems,
  error,
}
