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
      id: map['id'] as String,
      name: map['name'] as String,
      activeSubstance: map['activeSubstance'] as String,
      isSelected: map['isSelected'] as bool,
      manufacturer: map['manufacturer'] as String,
      therapeuticClasses: List<String>.from(
        (map['therapeuticClasses'] as List<String>),
      ),
      pdfLink: map['pdfLink'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicamentModel.fromJson(String source) =>
      MedicamentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
