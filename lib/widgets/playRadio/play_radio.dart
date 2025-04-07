import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_map/domain/model/radio_detail.dart';

class PlayRadio extends StatefulWidget {
  final RadioDetail? selectedRadio;

  const PlayRadio({super.key, required this.selectedRadio});

  @override
  State<PlayRadio> createState() => _PlayRadioState();
}

class _PlayRadioState extends State<PlayRadio> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _playRadio();
  }

  Future<void> _playRadio() async {
    if (widget.selectedRadio != null) {
      try {
        await _audioPlayer.setUrl(widget.selectedRadio!.url);
        _audioPlayer.play();
        setState(() {
          _isPlaying = true;
        });
      } catch (e) {
        return;
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.selectedRadio != null) ...[
          IconButton(
            icon: Icon(_isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill, size: 50),
            onPressed: () {
              setState(() {
                if (_isPlaying) {
                  _audioPlayer.pause();
                } else {
                  _audioPlayer.play();
                }
                _isPlaying = !_isPlaying;
              });
            },
          ),
        ] else
          const Text("No hay radio seleccionada"),
      ],
    );
  }
}
