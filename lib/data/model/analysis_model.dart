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
    return AnalysisModel(
      medications: List<Map<String, dynamic>>.from(json['medications'] ?? [])
          .map((med) => MedicamentModel.fromMap(med))
          .toList(),
      interaction: List<Map<String, dynamic>>.from(json['interactions'] ?? [])
          .map((json) => InteractionModel.fromJson(json))
          .toList(),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'medications': medications.map((med) => med.toJson()).toList(),
  //     'interactions': [interaction.toJson()],
  //   };
  // }
}

class InteractionModel {
  final int id;
  final String analysis;
  final int riskLevel;
  final DateTime? date;
  final String aiModel;
  final List<int> idMedications;

  InteractionModel({
    required this.id,
    required this.analysis,
    required this.riskLevel,
    required this.aiModel,
    required this.idMedications,
    this.date,
  });

  factory InteractionModel.fromJson(Map<String, dynamic> json) {
    return InteractionModel(
      id: json['id'] ?? 0,
      analysis: json['analysis']?.toString() ?? '',
      riskLevel: json['riskLevel'] ?? 0,
      date: DateTime.tryParse(json['date']),
      aiModel: json['aiModel'] ?? '',
      idMedications: List<int>.from(jsonDecode(json['idMedications'] ?? [])),
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
