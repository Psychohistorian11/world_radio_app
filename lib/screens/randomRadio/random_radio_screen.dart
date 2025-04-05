import 'package:flutter/material.dart';
import 'package:radio_map/widgets/country_s_radio.dart';
import 'package:radio_map/widgets/world_map.dart';

class RandomRadioScreen extends StatefulWidget {
  const RandomRadioScreen({super.key});

  @override
  State<RandomRadioScreen> createState() => _RandomRadioState();
}

class _RandomRadioState extends State<RandomRadioScreen> {
  String? selectedCountryCode;
  String? selectedCountryName;
  String? selectedCountryFlag;

  void _updateCountry(String countryName, String countryCode, String countryFlag) {
    setState(() {
      selectedCountryName = countryName;
      selectedCountryCode = countryCode;
      selectedCountryFlag = countryFlag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        title: const Text(
          'Radio Explorer',
          style: TextStyle(color: Colors.white, fontFamily: 'StyleScript', fontSize: 50),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(child: WorldMap(onCountrySelected: _updateCountry)),
          if (selectedCountryCode != null)
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  if (selectedCountryFlag != null)
                    Image.network(
                      selectedCountryFlag!,
                      width: 60,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      "Country: ",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "$selectedCountryName ($selectedCountryCode)",
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          if (selectedCountryCode != null)
            SizedBox(
              height: 120, 
              child: CountryRadio(
                key: ValueKey(selectedCountryCode),
                countryCode: selectedCountryCode!,
              ),
            ),
        ],
      ),
    );
  }
}
