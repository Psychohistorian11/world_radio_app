import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:radio_map/domain/model/radio_detail.dart';
import 'package:radio_map/domain/model/tag_detail.dart';

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
        
        final radios = data
            .map((json) => RadioDetail.fromJson(json))
            .where((radio) => radio.url.isNotEmpty && radio.favicon.isNotEmpty).take(50)
            .toList();

        final validRadios = <RadioDetail>[];

        final validations = radios.map((radio) async {
          final isValidImage = await _isValidImage(radio.favicon);
          final isValidStream = await _isValidStream(radio.url);
          if (isValidStream && isValidImage) {
            validRadios.add(radio);
          }
        }).toList();

        await Future.wait(validations);

        return validRadios.take(40).toList();

      } else {
        throw Exception('Error al obtener radios: Código ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la petición: $e');
    }
  }

  static Future<List<RadioDetail>> getRadiosByTag(String category) async {
    final url = Uri.parse('$_baseUrl/stations/byname/$category');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        final radios = data
            .map((json) => RadioDetail.fromJson(json))
            .where((radio) => radio.url.isNotEmpty && radio.favicon.isNotEmpty).take(50)
            .toList();

        final validRadios = <RadioDetail>[];

        final validations = radios.map((radio) async {
          final isValidImage = await _isValidImage(radio.favicon);
          final isValidStream = await _isValidStream(radio.url);
          if (isValidStream && isValidImage) {
            validRadios.add(radio);
          }
        }).toList();

        await Future.wait(validations);

        return validRadios.take(40).toList();
      } else {
        throw Exception('Error al obtener radios: Código ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en la petición: $e');
    }
  }

static Future<List<TagDetail>> getTags() async {
  // Simulamos un pequeño delay como si fuera una llamada real
  await Future.delayed(const Duration(seconds: 1));

  // Lista mockeada de tags populares
  final List<String> mockTags = [
    'Pop',
    'Rock',
    'Jazz',
    'Reggaeton',
    'Hip Hop',
    'Classical',
    'Electronic',
    'Country',
    'Blues',
    'Salsa',
    'Techno',
    'House',
    'Funk',
    'News',
    'Sports',
    'Talk',
    'Ambient',
    'Latin',
    'Anime',
    'K-Pop',
    'Metal',
    'Dance',
    'Trance',
    'Indie',
    'Folk',
    'Instrumental',
    'Gospel',
    'Disco',
    'Dubstep',
    'Lounge',
    'R&B',
    'Chillout',
  ];

  // Convertimos la lista a objetos TagDetail
  return mockTags.map((tag) => TagDetail(name: tag)).toList();
}


  static Future<bool> _isValidImage(String url) async {
    try {
      final response = await http.head(Uri.parse(url)).timeout(const Duration(seconds: 3));
      return response.statusCode == 200 &&
          response.headers['content-type']?.startsWith('image/') == true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> _isValidStream(String url) async {
    try {
      final response = await http.head(Uri.parse(url)).timeout(const Duration(seconds: 3));
      return response.statusCode == 200 &&
          response.headers['content-type']?.contains('audio/') == true;
    } catch (_) {
      return false;
    }
  }

}
