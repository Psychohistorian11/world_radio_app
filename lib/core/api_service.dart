import 'dart:convert';
import 'dart:math';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://fi1.api.radio-browser.info/json';

  /// Obtiene una radio aleatoria de un país por su código ISO (Ej: "CO" para Colombia)
  static Future<Map<String, dynamic>?> getRandomRadioByCountry(String countryCode) async {
    final radios = await getRadiosByCountry(countryCode);
    if (radios.isNotEmpty) {
      final random = Random();
      return radios[random.nextInt(radios.length)];
    }
    return null;
  }

  /// Obtiene una lista de radios de un país (máximo 20)
  static Future<List<Map<String, dynamic>>> getRadiosByCountry(String countryCode) async {
    final url = Uri.parse('$_baseUrl/stations/bycountrycodeexact/$countryCode');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        print("Total de radios recibidas para $countryCode: ${data.length}"); 
        return data.take(20).cast<Map<String, dynamic>>().toList(); // 🔥 Toma solo 20 radios
      } else {
        throw Exception('Error al obtener radios: Código ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la petición: $e');
    }
  }

  /// Obtiene radios relacionadas con una categoría o género (Ej: "jazz")
  static Future<List<Map<String, dynamic>>> getRadiosByCategory(String category) async {
    final url = Uri.parse('$_baseUrl/stations/byname/$category');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        print("Total de radios encontradas para $category: ${data.length}");
        return data.take(20).cast<Map<String, dynamic>>().toList(); // 🔥 Toma solo 20 radios
      } else {
        throw Exception('Error al obtener radios: Código ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la petición: $e');
    }
  }
}
