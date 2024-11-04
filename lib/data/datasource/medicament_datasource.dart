import 'package:dio/dio.dart';
import 'package:medicament_app/data/model/interaction_analysis.dart';
import 'package:medicament_app/data/model/medicament.dart';

class MedicationDataSource {
  final Dio dio;

  MedicationDataSource(this.dio);

  Future<List<InteractionAnalysisModel>> sendMedicationsForInteractionAnalysis(
      List<MedicamentModel> medications) async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      InteractionAnalysisModel(
        id: 0,
        medicaments: [3652639, 1607332],
        analysis: "Não existem interações medicamentosas negativas.",
        riskLevel: 0,
        date: DateTime.tryParse("2024-10-11T18:43:10.101Z"),
        aiModel: 'gemini',
      ),
      InteractionAnalysisModel(
        id: 0,
        medicaments: [3652639, 1607332],
        analysis: "Existem interações medicamentosas positivas.",
        riskLevel: 1,
        date: DateTime.tryParse("2024-10-11T18:43:10.101Z"),
        aiModel: 'gemini',
      )
    ];
    // try {
    //   final List<Map<String, dynamic>> jsonMedications =
    //       medications.map((medication) => medication.toMap()).toList();

    //   final response = await dio.get(
    //     ApiUrl.getInteractions,
    //     data: jsonMedications,
    //   );

    //   if (isResponseOk(response)) {
    //     return InteractionAnalysisModel.fromJson(response.data);
    //   } else {
    //     throw Exception(_handleResponseMessage(response.statusCode));
    //   }
    // } on DioException catch (e) {
    //   if (e.response != null) {
    //     throw Exception(_handleResponseMessage(e.response!.statusCode));
    //   } else {
    //     throw Exception("Erro de conexão. Verifique sua internet.");
    //   }
    // }
  }

  Future<List<MedicamentModel>> searchMedication(String medicationName) async {
    await Future.delayed(const Duration(seconds: 1));
    final results = _fakeMedicaments
        .where((medicament) => medicament.name
            .toLowerCase()
            .contains(medicationName.toLowerCase()))
        .toList();
    return results;
    // try {
    //   final response = await _dio.get(
    //     ApiUrl.searchMedication.replaceFirst('{{Medication}}', medicationName),
    //   );

    //   if (isResponseOk(response)) {
    //     final List data = response.data as List;
    //     return data.map((json) => MedicamentModel.fromJson(json)).toList();
    //   } else {
    //     throw Exception(_handleResponseMessage(response.statusCode));
    //   }
    // } on DioException catch (e) {
    //   if (e.response != null) {
    //     throw Exception(_handleResponseMessage(e.response!.statusCode));
    //   } else {
    //     throw Exception("Erro de conexão. Verifique sua internet.");
    //   }
    // }
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

final List<MedicamentModel> _fakeMedicaments = [
  // FENITOÍNA
  MedicamentModel(
    name: 'TYLENOL',
    id: '3652639',
    activeSubstance: 'PARACETAMOL',
    manufacturer: 'JOHNSON & JOHNSON INDUSTRIAL LTDA.',
    therapeuticClasses: ['ANALGESICOS NAO NARCOTICOS'],
    pdfLink:
        'eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIyMzQzMDQyOSIsIm5iZiI6MTcyODY3MzY4NSwiZXhwIjoxNzI4NjczOTg1fQ.KmmRnZ8seUGBoP4_FyCYjeFSra97POHoY2-OhvQeKDyvoPT7p4wNMx3aYdJk5SQYymwmqYDyTx3DmpXTEdERbQ',
  ),
  MedicamentModel(
    name: 'BUSCOPAN',
    id: '1607332',
    activeSubstance: 'BUTILBROMETO DE ESCOPOLAMINA',
    manufacturer: 'COSMED INDUSTRIA DE COSMETICOS E MEDICAMENTOS S.A.',
    therapeuticClasses: [
      'ANTIESPASMODICOS E ANTICOLINERGICOS GASTRINTESTINAIS'
    ],
    pdfLink:
        'eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIyMDI0OTkyOCIsIm5iZiI6MTcyODY3Mzc0NSwiZXhwIjoxNzI4Njc0MDQ1fQ.w9yaclY8nBAOHixnDbS5a0Ycy4lKE0sDIVY9oRHdKBPaZH37LYuEnelISOxWJ0ANpmBb34hsqcOrXpQWKIv0yQ',
  ),
];
