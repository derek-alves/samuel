import 'package:dio/dio.dart';
import 'package:medicament_app/data/model/analysis_model.dart';
import 'package:medicament_app/data/model/medicament.dart';
import 'package:medicament_app/data/url/api_url.dart';

class MedicationDataSource {
  final Dio dio;

  MedicationDataSource(this.dio);

  Future<AnalysisModel> sendMedicationsForInteractionAnalysis(
      List<MedicamentModel> medications) async {
    try {
      final List<String> jsonMedications =
          medications.map((medication) => medication.id).toList();

      final response = await dio.get(
        ApiUrl.getInteractions,
        data: jsonMedications,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (isResponseOk(response)) {
        return AnalysisModel.fromJson(response.data);
      } else {
        throw Exception(_handleResponseMessage(response.statusCode));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(_handleResponseMessage(e.response!.statusCode));
      } else {
        throw Exception("Erro de conexão. Verifique sua internet.");
      }
    }
  }

  Future<List<MedicamentModel>> searchMedication(String medicationName) async {
    await Future.delayed(const Duration(seconds: 1));

    final value =
        ApiUrl.searchMedication.replaceFirst('{{Medication}}', medicationName);
    try {
      final response = await dio.get(
        value,
      );

      if (isResponseOk(response)) {
        final List data = response.data as List;
        return data.map((json) => MedicamentModel.fromMap(json)).toList();
      } else {
        throw Exception(_handleResponseMessage(response.statusCode));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(_handleResponseMessage(e.response!.statusCode));
      } else {
        throw Exception("Erro de conexão. Verifique sua internet.");
      }
    }
  }

  bool isResponseOk(Response response) {
    return response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;
  }

  String _handleResponseMessage(int? statusCode) {
    switch (statusCode) {
      case 200:
        return "Requisição bem-sucedida.";
      case 201:
        return "Recurso criado com sucesso.";
      case 204:
        return "Nenhum conteúdo. A operação foi bem-sucedida, mas não há conteúdo para retornar.";
      case 400:
        return "Solicitação inválida. Verifique os parâmetros e tente novamente.";
      case 404:
        return "Medicamento não encontrado.";
      case 500:
        return "Erro interno no servidor. Tente novamente mais tarde.";
      default:
        return "Status desconhecido. Código de status: $statusCode";
    }
  }
}
