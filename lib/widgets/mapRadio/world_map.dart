import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:radio_map/core/map_api_service.dart';
import 'package:radio_map/domain/model/country_detail.dart';

final myPosition = LatLng(6.2961654, -75.5663604);
const _mapboxToken = 'pk.eyJ1IjoicHN5Y2hvaGlzdG9yaWFuIiwiYSI6ImNtOHRhaHA4aDA5ZTkydHEzY2Y3MjJobjcifQ.W6u_logpDxJ74KzSdS6ljA';

class WorldMap extends StatefulWidget {
  final Function(String, String, String) onCountrySelected;
  const WorldMap({super.key, required this.onCountrySelected});

  @override
  State<WorldMap> createState() => _WorldRadioState();
}

  class _WorldRadioState extends State<WorldMap> {

    void _getCountryInfo(LatLng position) async {
    CountryDetail? country = await MapApiService.getCountryInfo(position);
    if (country != null) {
      widget.onCountrySelected(country.name, country.shortCode, country.flagUrl);
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
              'accessToken': _mapboxToken,
            },
          ),
        ],
      ),
    );
  }
}
