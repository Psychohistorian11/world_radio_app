import 'package:flutter/material.dart';
import 'package:radio_map/core/radio_api_service.dart';
import 'package:radio_map/domain/model/radio_detail.dart';
import 'package:radio_map/domain/model/tag_detail.dart';
import 'package:radio_map/widgets/playRadio/radio_menu.dart';

class RadioListByTag extends StatefulWidget {
  final TagDetail tag;
  const RadioListByTag({super.key, required this.tag});

  @override
  State<RadioListByTag> createState() => _RadioListByTagState();
}

class _RadioListByTagState extends State<RadioListByTag>{
  
  List<RadioDetail>? _radios;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRadios();
  }

  Future<void> _fetchRadios() async {
    try {
      final radios = await RadioApiService.getRadiosByTag(widget.tag.name);
      setState(() {
        _radios = radios;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Radios: ${widget.tag.name}", 
        style: TextStyle(color: Colors.white, fontFamily: 'StyleScript', fontSize: 30))),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _radios == null || _radios!.isEmpty
              ? const Center(child: Text("Not Radios found."))
              : ListView.builder(
                  itemCount: _radios!.length,
                  itemBuilder: (context, index) {
                    final radio = _radios![index];
                    return ListTile(
                      leading: radio.favicon.isNotEmpty
                          ? Image.network(radio.favicon, width: 40, height: 40, fit: BoxFit.cover)
                          : const Icon(Icons.radio),
                      title: Text(radio.name),
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