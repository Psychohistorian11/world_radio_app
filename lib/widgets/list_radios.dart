import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListRadios extends StatefulWidget {
    final String countryCode;

  const ListRadios({super.key, required this.countryCode});


  @override
  State<ListRadios> createState() => _ListRadiosState();
}

class _ListRadiosState extends State<ListRadios> {

    List<dynamic> _radios = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRadios();
  }

  Future<void> _fetchRadios() async {
    final url = Uri.parse('https://fi1.api.radio-browser.info/json/stations/bycountrycodeexact/${widget.countryCode}');
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _radios = data.take(10).toList(); // Solo mostrar 10 radios
          _isLoading = false;
        });
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error obteniendo radios: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }
   @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _radios.isEmpty
            ? const Center(child: Text("No se encontraron radios"))
            : ListView.builder(
                itemCount: _radios.length,
                itemBuilder: (context, index) {
                  final radio = _radios[index];
                  return ListTile(
                    leading: radio['favicon'] != null && radio['favicon'].isNotEmpty
                        ? Image.network(radio['favicon'], width: 40, height: 40, fit: BoxFit.cover)
                        : const Icon(Icons.radio, size: 40, color: Colors.amber),
                    title: Text(radio['name']),
                    subtitle: Text(radio['url']),
                  );
                },
              );
  }
}