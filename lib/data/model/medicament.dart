// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MedicamentModel {
  final String id;
  final String name;
  final String activeSubstance;
  final bool isSelected;
  final String manufacturer;
  final List<String> therapeuticClasses;
  final String pdfLink;

  MedicamentModel({
    required this.activeSubstance,
    required this.manufacturer,
    required this.therapeuticClasses,
    required this.pdfLink,
    required this.id,
    required this.name,
    this.isSelected = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'activeSubstance': activeSubstance,
      'isSelected': isSelected,
      'manufacturer': manufacturer,
      'therapeuticClasses': therapeuticClasses,
      'pdfLink': pdfLink,
    };
  }

  factory MedicamentModel.fromMap(Map<String, dynamic> map) {
    return MedicamentModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      activeSubstance: map['activeSubstance']?.toString() ?? '',
      isSelected: map['isSelected'] ?? false,
      manufacturer: map['manufacturer']?.toString() ?? '',
      therapeuticClasses: List<String>.from(
        (map['therapeuticClasses'] ?? <String>[]),
      ),
      pdfLink: map['pdfLink']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicamentModel.fromJson(String source) =>
      MedicamentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
