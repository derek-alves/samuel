class InteractionAnalysisModel {
  final int id;

  final String analysis;
  final int riskLevel;
  final DateTime? date;
  final String aiModel;
  final List<int> medicaments;

  InteractionAnalysisModel({
    required this.id,
    required this.analysis,
    required this.riskLevel,
    required this.aiModel,
    required this.medicaments,
    this.date,
  });

  factory InteractionAnalysisModel.fromJson(Map<String, dynamic> json) {
    return InteractionAnalysisModel(
      medicaments: json['medicaments'] != null
          ? List<int>.from(json['medicaments'])
          : [],
      id: json['id'],
      analysis: json['analysis'],
      riskLevel: json['riskLevel'],
      date: DateTime.parse(json['date']),
      aiModel: json['aiModel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'analysis': analysis,
      'riskLevel': riskLevel,
      'date': date?.toIso8601String(),
      'aiModel': aiModel,
    };
  }
}
