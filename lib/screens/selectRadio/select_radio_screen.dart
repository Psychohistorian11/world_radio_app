import 'package:flutter/material.dart';
import 'package:radio_map/widgets/country_list.dart';
import 'package:radio_map/widgets/country_search.dart';


class SelectRadioScreen extends StatefulWidget {
  const SelectRadioScreen({super.key});

  @override
  State<SelectRadioScreen> createState() => _SelectRadioState();
}

class _SelectRadioState extends State<SelectRadioScreen> {
  String searchQuery = '';

  void _onSearch(String query) {
    setState(() {
      searchQuery = query;
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.white, fontFamily: 'StyleScript', fontSize: 50),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          CountrySearch(onSearch: _onSearch),
          Expanded(
              child: CountryList(searchQuery: searchQuery),
            ),
        ],
      ),
    );
  }
}

