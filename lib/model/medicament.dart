import 'dart:convert';

class MedicamentModel {
  final String id;
  final String name;
  bool isSelected;

  MedicamentModel({
    required this.id,
    required this.name,
    this.isSelected = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'isSelected': isSelected,
    };
  }

  factory MedicamentModel.fromMap(Map<String, dynamic> map) {
    return MedicamentModel(
      id: map['id'] as String,
      name: map['name'] as String,
      isSelected: map['isSelected'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicamentModel.fromJson(String source) =>
      MedicamentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
