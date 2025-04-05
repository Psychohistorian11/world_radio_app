import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:radio_map/domain/model/country_detail.dart';


class MapApiService {
  static const String _mapboxToken = 'pk.eyJ1IjoicHN5Y2hvaGlzdG9yaWFuIiwiYSI6ImNtOHRhaHA4aDA5ZTkydHEzY2Y3MjJobjcifQ.W6u_logpDxJ74KzSdS6ljA';


  static Future<CountryDetail?> getCountryInfo(LatLng position) async {
    final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/${position.longitude},${position.latitude}.json?access_token=$_mapboxToken');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['features'].isNotEmpty) {
          for (var feature in data['features']) {
            if (feature['place_type'].contains('country')) {
              return CountryDetail.mapBoxfromJson(feature);
            }
          }
        }
      }
    } catch (e) {
      print('Error obteniendo país: $e');
    }
    return null; 
  }
}