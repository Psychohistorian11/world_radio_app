import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://fi1.api.radio-browser.info/json';

  /// Obtiene las radios de un país por su código ISO (Ej: "CO" para Colombia)
  static Future<List<Map<String, dynamic>>> getRadiosByCountry(String countryCode) async {
    final url = Uri.parse('$_baseUrl/stations/bycountrycodeexact/$countryCode');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
          print("Total de radios recibidas: ${data.length}"); // 🔍 Verifica cuántas radios llegan

      return data.take(10).cast<Map<String, dynamic>>().toList(); // 🔥 Solo toma las primeras 10
      } else {
        throw Exception('Error al obtener radios: Código ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la petición: $e');
    }
  } 
}
