class ApiUrl {
  static const String baseUrl = 'http://10.0.2.2:3000/api/';

  static const String searchMedication =
      '${baseUrl}medication/name/{{Medication}}';

  static const String getInteractions = '${baseUrl}interactions';
}
