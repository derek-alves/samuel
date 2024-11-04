import 'package:medicament_app/data/datasource/medicament_datasource.dart';
import 'package:medicament_app/data/model/medicament.dart';
import 'package:medicament_app/data/util/result.dart';

class GetMedicamentUsecase {
  final MedicationDataSource medicationDataSource;

  GetMedicamentUsecase(this.medicationDataSource);

  Future<Result<List<MedicamentModel>>> execute(String medicationName) async {
    try {
      final result =
          await medicationDataSource.searchMedication(medicationName);
      return Success<List<MedicamentModel>>(result);
    } on Exception catch (e) {
      return Error<List<MedicamentModel>>(e.toString());
    }
  }
}
