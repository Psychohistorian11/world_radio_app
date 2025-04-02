import 'package:flutter/material.dart';
import 'package:radio_map/components/list_radios.dart';
import 'package:radio_map/components/radio_map.dart';

class SelectRadioScreen extends StatefulWidget {
  const SelectRadioScreen({super.key});

  @override
  State<SelectRadioScreen> createState() => _SelectRadioState();
}

class _SelectRadioState extends State<SelectRadioScreen> {
  String? selectedCountryCode;
  String? selectedCountryName;
  String? selectedCountryFlag;

  void _updateCountry(String countryName, String countryCode, String countryFlag) {
    setState(() {
      selectedCountryName = countryName;
      selectedCountryCode = countryCode;
      selectedCountryFlag = countryFlag;
    });
    print("País seleccionado: $countryName ($countryCode)"); // Debug
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: RadioMap(onCountrySelected: _updateCountry)),
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
              height: 300, 
              child: ListRadios(
                key: ValueKey(selectedCountryCode), 
                countryCode: selectedCountryCode!,
              ),
            ),
        ],
      ),
    );
  }
}