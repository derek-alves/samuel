import 'dart:convert';

import 'package:medicament_app/data/model/medicament.dart';

class AnalysisModel {
  final List<MedicamentModel> medications;
  final List<InteractionModel> interaction;

  const AnalysisModel({
    required this.medications,
    required this.interaction,
  });

  factory AnalysisModel.fromJson(Map<String, dynamic> json) {
    final medicaments =
        List<Map<String, dynamic>>.from(json['medications'] ?? [])
            .map((med) => MedicamentModel.fromMap(med))
            .toList();
    return AnalysisModel(
      medications: medicaments,
      interaction: List<Map<String, dynamic>>.from(json['interactions'] ?? [])
          .map((json) => InteractionModel.fromJson(json, medicaments))
          .toList(),
    );
  }
}

class InteractionModel {
  final int id;
  final String analysis;
  final int riskLevel;
  final DateTime? date;
  final String aiModel;
  final List<int> idMedications;
  final List<MedicamentModel> medications;

  InteractionModel({
    required this.id,
    required this.analysis,
    required this.riskLevel,
    required this.aiModel,
    required this.idMedications,
    required this.medications,
    this.date,
  });

  factory InteractionModel.fromJson(
    Map<String, dynamic> json,
    List<MedicamentModel> medications,
  ) {
    List<int> idMedications =
        List<int>.from(jsonDecode(json['idMedications'] ?? '[]'));

    return InteractionModel(
      medications: medications
          .where((med) => idMedications.contains(int.parse(med.id)))
          .toList(),
      id: json['id'] ?? 0,
      analysis: json['analysis']?.toString() ?? '',
      riskLevel: json['riskLevel'] ?? 0,
      date: DateTime.tryParse(json['date']),
      aiModel: json['aiModel'] ?? '',
      idMedications: idMedications,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'analysis': analysis,
      'riskLevel': riskLevel,
      'date': date?.toIso8601String(),
      'aiModel': aiModel,
      'idMedications': jsonEncode(idMedications),
    };
  }
}
