import 'package:flutter/material.dart';
import 'package:radio_map/components/map_radio.dart';


class RandomRadioScreen extends StatefulWidget {
  const RandomRadioScreen({super.key});

  @override
  State<RandomRadioScreen> createState() => _RandomRadioState();
}

class _RandomRadioState extends State<RandomRadioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapRadio()
    );
  }
}