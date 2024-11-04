import 'package:dio/dio.dart';
import 'package:medicament_app/data/datasource/medicament_datasource.dart';

MedicationDataSource buildMedicamentDataSource() {
  return MedicationDataSource(Dio());
}
