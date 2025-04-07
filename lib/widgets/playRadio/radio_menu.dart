import 'package:flutter/material.dart';
import 'package:radio_map/domain/model/radio_detail.dart';
import 'package:radio_map/widgets/playRadio/play_radio.dart';

class RadioMenu extends StatelessWidget {
  final RadioDetail selectedRadio;
  const RadioMenu({super.key, required this.selectedRadio});

  @override
  Widget build(BuildContext context) {
    return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        if (selectedRadio.favicon.isNotEmpty)
                          Image.network(selectedRadio.favicon,
                              width: 80, height: 80, fit: BoxFit.cover)
                        else
                          const Icon(Icons.radio, size: 80, color: Colors.amber),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 200,
                          child: Text(
                            selectedRadio.name,
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