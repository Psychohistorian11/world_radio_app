import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final myPosition = LatLng(6.2961654, -75.5663604);
const MAPBOX_ACCESS_TOKEN = 'pk.eyJ1IjoicHN5Y2hvaGlzdG9yaWFuIiwiYSI6ImNtOHRhaHA4aDA5ZTkydHEzY2Y3MjJobjcifQ.W6u_logpDxJ74KzSdS6ljA';

class RadioMap extends StatefulWidget {
  final Function(String, String, String) onCountrySelected;
  const RadioMap({super.key, required this.onCountrySelected});

  @override
  State<RadioMap> createState() => _MapRadioState();
}

class _MapRadioState extends State<RadioMap> {
  void _getCountryInfo(LatLng position) async {
    final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/${position.longitude},${position.latitude}.json?access_token=$MAPBOX_ACCESS_TOKEN');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['features'].isNotEmpty) {
          for (var feature in data['features']) {
            if (feature['place_type'].contains('country')) {
              String countryName = feature['text'] ?? 'Unknown';
              String countryCode = feature['properties']['short_code'] ?? 'Unknown';
              String flagUrl = "https://flagcdn.com/w320/${countryCode.toLowerCase()}.png";
              widget.onCountrySelected(countryName, countryCode.toUpperCase(), flagUrl);
              return;
            }
          }
        }
      }
    } catch (e) {
      print('Error obteniendo país: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: myPosition,
          minZoom: 1,
          maxZoom: 18,
          initialZoom: 4,
          onTap: (tapPosition, point) {
            _getCountryInfo(point);
          },
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/mapbox/dark-v11/tiles/{z}/{x}/{y}?access_token={accessToken}',
            additionalOptions: {
              'accessToken': MAPBOX_ACCESS_TOKEN,
            },
          ),
        ],
      ),
    );
  }
}
