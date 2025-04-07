import 'package:flutter/material.dart';
import 'package:radio_map/core/country_api_service.dart';
import 'package:radio_map/domain/model/country_detail.dart';
import 'package:radio_map/widgets/searchRadio/radio_list_by_country.dart';

class CountryList extends StatefulWidget {
  final String searchQuery;

  const CountryList({super.key, required this.searchQuery});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  List<CountryDetail> countries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

   @override
  void didUpdateWidget(covariant CountryList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      _fetchCountries();
    }
  }


  Future<void> _fetchCountries() async {
    setState(() => _isLoading = true);

    List<CountryDetail> data = await CountryApiService.getCountries(widget.searchQuery);
    setState(() {
      countries = data;
      _isLoading = false;
    });
  }


   @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (countries.isEmpty) return const Center(child: Text("Not countries found."));
    

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: countries.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, 
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 4 / 3, 
        ),
        itemBuilder: (context, index) {
          final country = countries[index];

          return GestureDetector(
            onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RadioListByCountry(
                          countryCode: country.shortCode, 
                        ),
                      ),
                    );
                  },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(country.flagUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(6),
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black87],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),  
                child: Text(
                  country.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
