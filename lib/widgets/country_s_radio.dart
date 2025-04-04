import 'package:flutter/material.dart';
import 'package:radio_map/widgets/play_radio.dart';
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
      setState(() {
        selectedRadio = radio;
        _isLoading = false;
      });
    } catch (e) {
      print("Error obteniendo radio: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : selectedRadio == null
            ? const Center(child: Text("No se encontró una radio"))
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        if (selectedRadio!.favicon.isNotEmpty)
                          Image.network(selectedRadio!.favicon,
                              width: 80, height: 80, fit: BoxFit.cover)
                        else
                          const Icon(Icons.radio, size: 80, color: Colors.amber),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 200,
                          child: Text(
                            selectedRadio!.name,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        PlayRadio(selectedRadio: selectedRadio),
                      ],
                    ),
                  ),
                ],
              );
  }
}
