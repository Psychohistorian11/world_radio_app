import 'package:flutter/material.dart';
import 'package:radio_map/widgets/playRadio/radio_menu.dart';
import '../core/radio_api_service.dart';
import 'package:radio_map/domain/model/radio_detail.dart';

class CountryRadio extends StatefulWidget {
  final String countryCode;

  const CountryRadio({super.key, required this.countryCode});

  @override
  State<CountryRadio> createState() => _CountryRadioState();
}

class _CountryRadioState extends State<CountryRadio> {
  RadioDetail? selectedRadio;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRandomRadio();
  }

Future<void> _fetchRandomRadio() async {
  try {
    RadioDetail? radio = await RadioApiService.getRandomRadioByCountry(widget.countryCode);
    if (!mounted) return;
    setState(() {
      selectedRadio = radio;
      _isLoading = false;
    });
  } catch (e) {
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return _isLoading ? 
            const Center(child: CircularProgressIndicator()) :
             selectedRadio == null ? 
              const Center(child: Text("Not radios found")) : 
                RadioMenu(selectedRadio: selectedRadio!);
  }
}
