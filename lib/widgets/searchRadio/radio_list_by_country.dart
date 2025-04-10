import 'package:flutter/material.dart';
import 'package:radio_map/core/radio_api_service.dart';
import 'package:radio_map/domain/model/radio_detail.dart';
import 'package:radio_map/widgets/playRadio/radio_menu.dart';

class RadioListByCountry extends StatefulWidget {
    final String countryCode;

  const RadioListByCountry({super.key, required this.countryCode});


  @override
  State<RadioListByCountry> createState() => _ListRadiosState();
}

class _ListRadiosState extends State<RadioListByCountry> {

  List<RadioDetail>? _radios;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchListRadios();
  }

  Future<void> _fetchListRadios() async {
      try{
           List<RadioDetail> radios = await RadioApiService.getRadiosByCountry(widget.countryCode);
           setState(() {
               _radios = radios;
              _isLoading = false;
           });
      }catch (e)  {
          setState(() {
            _isLoading = true;
          });
      }
  }
   @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blueGrey,
      title: Text("${widget.countryCode.toUpperCase()}   Radios", 
      style: TextStyle(color: Colors.white, fontFamily: 'StyleScript', fontSize: 30),), 
    ),
    body: _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _radios!.isEmpty
            ? const Center(child: Text("Not radios found"))
            : ListView.builder(
                itemCount: _radios!.length,
                itemBuilder: (context, index) {
                  final radio = _radios![index];
                  return ListTile(
                    leading: radio.favicon.isNotEmpty
                        ? Image.network(radio.favicon, width: 40, height: 40, fit: BoxFit.cover)
                        : const Icon(Icons.radio, size: 40, color: Colors.amber),
                    title: Text(
                      radio.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      radio.url,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, 
                        shape: const RoundedRectangleBorder(
                        ),
                        builder: (context) => DraggableScrollableSheet(
                          initialChildSize: 0.15, 
                          minChildSize: 0.1,
                          maxChildSize: 0.9,
                          expand: false,
                          builder: (context, scrollController) {
                            return RadioMenu(
                              selectedRadio: radio,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
  );
}

}