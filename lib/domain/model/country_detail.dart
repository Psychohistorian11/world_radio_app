class CountryDetail {
  final String name;
  final String shortCode;
  final String flagUrl;

  CountryDetail({
    required this.name,
    required this.shortCode,
    required this.flagUrl,
  });

  factory CountryDetail.mapBoxfromJson(Map<String, dynamic> json) {
    String name = json['text'] ?? 'Unknown';
    String code = json['properties']['short_code'] ?? 'Unknown';
    return CountryDetail(
      name: name,
      shortCode: code.toUpperCase(),
      flagUrl: "https://flagcdn.com/w320/${code.toLowerCase()}.png",
    );
  }

  factory CountryDetail.restCountryFromJson(Map<String, dynamic> json) {
    final shortCode = json['cca2'] ?? '';
    return CountryDetail(
      name: json['name']['common'] ?? 'Unknown',
      shortCode: shortCode,
      flagUrl: 'https://flagcdn.com/w80/${shortCode.toLowerCase()}.png',
    );
  }
}
