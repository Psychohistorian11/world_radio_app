import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:radio_map/domain/model/radio_detail.dart';

class RadioApiService {
  static const String _baseUrl = 'https://fi1.api.radio-browser.info/json';

  static Future<RadioDetail?> getRandomRadioByCountry(String countryCode) async {
    final radios = await getRadiosByCountry(countryCode);
    if (radios.isNotEmpty) {
      final random = Random();
      return radios[random.nextInt(radios.length)];
    }
    return null;
  }

  static Future<List<RadioDetail>> getRadiosByCountry(String countryCode) async {
    final url = Uri.parse('$_baseUrl/stations/bycountrycodeexact/$countryCode');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.take(20).map((json) => RadioDetail.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener radios: Código ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la petición: $e');
    }
  }

  static Future<List<RadioDetail>> getRadiosByCategory(String category) async {
    final url = Uri.parse('$_baseUrl/stations/byname/$category');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        print("Total de radios encontradas para $category: \${data.length}");
        return data.take(20).map((json) => RadioDetail.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener radios: Código ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la petición: $e');
    }
  }
}
