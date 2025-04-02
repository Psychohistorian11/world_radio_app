import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

final myPosition = LatLng(6.2961654, -75.5663604);
// ignore: constant_identifier_names
const MAPBOX_ACCESS_TOKEN = 'pk.eyJ1IjoicHN5Y2hvaGlzdG9yaWFuIiwiYSI6ImNtOHRhaHA4aDA5ZTkydHEzY2Y3MjJobjcifQ.W6u_logpDxJ74KzSdS6ljA';


class MapRadio extends StatefulWidget {
  const MapRadio({super.key});
  

  @override
  State<MapRadio> createState() => _MapRadioState();
}

class _MapRadioState extends State<MapRadio> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: myPosition,
          minZoom: 1, // Ver más mapa al inicio
          maxZoom: 18,
          initialZoom: 2,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/mapbox/dark-v11/tiles/{z}/{x}/{y}?access_token={accessToken}',
            additionalOptions: {
              'accessToken': MAPBOX_ACCESS_TOKEN,
            },
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: myPosition,
                width: 40,
                height: 40,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.radio,
                  color: Colors.amber,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
    
  }
}