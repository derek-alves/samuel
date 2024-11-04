import 'package:medicament_app/data/datasource/medicament_datasource.dart';
import 'package:medicament_app/data/model/interaction_result.dart';
import 'package:medicament_app/data/model/medicament.dart';
import 'package:medicament_app/data/util/result.dart';

class GetInteractionUsecase {
  final MedicationDataSource medicationDataSource;

  GetInteractionUsecase(this.medicationDataSource);

  Future<Result<List<InteractionResult>>> execute(
      List<MedicamentModel> medicaments) async {
    try {
      final result = await medicationDataSource
          .sendMedicationsForInteractionAnalysis(medicaments);
      return Success<List<InteractionResult>>([
        ...result.map((e) => InteractionResult(
              medicamentsIds: e.medicaments,
              message: e.analysis,
              success: e.riskLevel == 0,
            )),
      ]);
    } on Exception catch (e) {
      return Error<List<InteractionResult>>(e.toString());
    }
  }
}
