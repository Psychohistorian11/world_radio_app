import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

final myPosition = LatLng(6.2961654, -75.5663604);
const MAPBOX_ACCESS_TOKEN = '';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('World Radio App')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: myPosition,
          minZoom: 2, // Ver más mapa al inicio
          maxZoom: 18,
          initialZoom: 4,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/{z}/{x}/{y}?access_token={accessToken}',
            additionalOptions: {
              'accessToken': MAPBOX_ACCESS_TOKEN,
              'id': 'mapbox/dark-v11',
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
                  Icons.person_pin,
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
