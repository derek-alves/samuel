import 'package:medicament_app/data/usecase/get_interaction_usecase.dart';
import 'package:medicament_app/di/build_medicament_datasource.dart';

GetInteractionUsecase buildGetInteractionUsecase() {
  return GetInteractionUsecase(buildMedicamentDataSource());
}
