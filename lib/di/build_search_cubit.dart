import 'package:medicament_app/di/build_get_medicament_usecase.dart';
import 'package:medicament_app/presentation/search/cubit/search_cubit.dart';

SearchCubit buildSearchCubit() {
  return SearchCubit(
    getMedicamentUsecase: buildGetMedicamentUsecase(),
  );
}
