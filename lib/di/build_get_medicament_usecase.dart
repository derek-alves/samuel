import 'package:medicament_app/data/usecase/get_medicament_usecase.dart';
import 'package:medicament_app/di/build_medicament_datasource.dart';

GetMedicamentUsecase buildGetMedicamentUsecase() {
  return GetMedicamentUsecase(buildMedicamentDataSource());
}
