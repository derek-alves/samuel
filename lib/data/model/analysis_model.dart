import 'dart:convert';

import 'package:medicament_app/data/model/medicament.dart';

class AnalysisModel {
  final List<MedicamentModel> medications;
  final InteractionModel interaction;

  AnalysisModel({
    required this.medications,
    required this.interaction,
  });

  factory AnalysisModel.fromJson(Map<String, dynamic> json) {
    return AnalysisModel(
      medications: (json['medications'] as List)
          .map((med) => MedicamentModel.fromJson(med))
          .toList(),
      interaction: InteractionModel.fromJson(
          json['interactions'][0]), // Assumindo que há apenas um item na lista
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medications': medications.map((med) => med.toJson()).toList(),
      'interactions': [interaction.toJson()],
    };
  }
}

class InteractionModel {
  final int id;
  final String analysis;
  final int riskLevel;
  final DateTime date;
  final String aiModel;
  final List<int> idMedications;

  InteractionModel({
    required this.id,
    required this.analysis,
    required this.riskLevel,
    required this.date,
    required this.aiModel,
    required this.idMedications,
  });

  factory InteractionModel.fromJson(Map<String, dynamic> json) {
    return InteractionModel(
      id: json['id'],
      analysis: json['analysis'],
      riskLevel: json['riskLevel'],
      date: DateTime.parse(json['date']),
      aiModel: json['aiModel'],
      idMedications: List<int>.from(jsonDecode(json['idMedications'])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'analysis': analysis,
      'riskLevel': riskLevel,
      'date': date.toIso8601String(),
      'aiModel': aiModel,
      'idMedications': jsonEncode(idMedications),
    };
  }
}
