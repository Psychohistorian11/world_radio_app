class RadioDetail {
  final String name;
  final String url;
  final String favicon;
  final String country;
  final String tags;

  RadioDetail({
    required this.name,
    required this.url,
    required this.favicon,
    required this.country,
    required this.tags,
  });

  factory RadioDetail.fromJson(Map<String, dynamic> json){
      String name = json['name'] ?? 'name unknown';
      String url = json['url'] ?? 'Url unknown';
      String favicon = json['favicon'] ?? 'Url unknown';
      String country = json['country'] ?? 'Url unknown';
      String tags = json['tags'] ?? 'Url unknown';
      return RadioDetail(
        name: name, 
        url: url, 
        favicon: favicon, 
        country: country, 
        tags: tags);
  }
}