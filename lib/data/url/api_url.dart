class ApiUrl {
  static const String baseUrl = 'http://localhost:3000/api/';

  static const String searchMedication =
      '${baseUrl}SearchMedication/{{Medication}}';

  static const String getInteractions = '$baseUrl/GetInteractions';
}
