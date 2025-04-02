import 'package:flutter/material.dart';
import 'package:radio_map/components/play_radio.dart';
import '../core/api_service.dart';

class CountryRadio extends StatefulWidget {
  final String countryCode;

  const CountryRadio({super.key, required this.countryCode});

  @override
  State<CountryRadio> createState() => _CountryRadioState();
}

class _CountryRadioState extends State<CountryRadio> {
  Map<String, dynamic>? _selectedRadio;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRandomRadio();
  }

  Future<void> _fetchRandomRadio() async {
    try {
      final radio = await ApiService.getRandomRadioByCountry(widget.countryCode);
      setState(() {
        _selectedRadio = radio;
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
    return _isLoading ? const Center(child: CircularProgressIndicator())
        : _selectedRadio == null
            ? const Center(child: Text("No se encontró una radio"))
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        if (_selectedRadio!["favicon"] != null && _selectedRadio!["favicon"].isNotEmpty)
                      Image.network(_selectedRadio!["favicon"], width: 80, height: 80, fit: BoxFit.cover)
                    else
                      const Icon(Icons.radio, size: 80, color: Colors.amber),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        _selectedRadio!["name"],
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),

                    PlayRadio(selectedRadio: _selectedRadio),
                      ],
                    ),
                  ),
                  
                ],
              );


  }
}
