import 'package:flutter/material.dart';

class CountrySearch extends StatefulWidget {
  final Function(String) onSearch; 

  const CountrySearch({super.key, required this.onSearch});

  @override
  State<CountrySearch> createState() => _CountrySearchState();
}

class _CountrySearchState extends State<CountrySearch> {
  final TextEditingController _controller = TextEditingController();

  void _handleSearch() {
    String query = _controller.text.trim();
    if (query.isNotEmpty) {
      widget.onSearch(query); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
      child: TextField(
        controller: _controller,
        style: TextStyle(color: Colors.black),
        onSubmitted: (_) => _handleSearch(), 
        decoration: InputDecoration(
          hintText: 'Search country...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.blue),
            onPressed: _handleSearch, 
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
