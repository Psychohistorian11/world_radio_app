import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:radio_map/domain/model/country_detail.dart';

class CountryApiService {

  static Future<List<CountryDetail>> getCountries(String query) async {
    try {
      final url = Uri.parse('https://restcountries.com/v3.1/all?fields=name,flags,cca2');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        final countries = data.map((item) => CountryDetail.restCountryFromJson(item)).toList();

        if (query.isNotEmpty) {
          return countries
              .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }

        return countries;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}