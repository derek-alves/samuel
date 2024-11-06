import 'package:medicament_app/data/datasource/medicament_datasource.dart';
import 'package:medicament_app/data/model/analysis_model.dart';
import 'package:medicament_app/data/model/medicament.dart';
import 'package:medicament_app/data/util/result.dart';

class GetInteractionUsecase {
  final MedicationDataSource medicationDataSource;

  GetInteractionUsecase(this.medicationDataSource);

  Future<Result<AnalysisModel>> execute(
      List<MedicamentModel> medicaments) async {
    try {
      final result = await medicationDataSource
          .sendMedicationsForInteractionAnalysis(medicaments);
      return Success<AnalysisModel>(result);
    } on Exception catch (e) {
      return Error<AnalysisModel>(e.toString());
    }
  }
}
