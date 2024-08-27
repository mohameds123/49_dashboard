import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rx_dart;

import '../../../../data/model/position_data_model.dart';
import 'audio_control_buttons.dart';
import 'audio_seek_bar.dart';

class AudioItemWidget extends StatefulWidget {
  final String audioUrl;
  final String? picture;

  const AudioItemWidget({super.key, required this.audioUrl, this.picture});

  @override
  State<AudioItemWidget> createState() => _AudioItemWidgetState();
}

class _AudioItemWidgetState extends State<AudioItemWidget> {
  final player = AudioPlayer();
  late final audioSource = LockCachingAudioSource(
    Uri.parse(
      widget.audioUrl,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.picture != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: widget.picture!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          AudioControlButtons(player, audioSource),
          StreamBuilder<PositionDataModel>(
            stream: positionDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return AudioSeekBar(
                duration: positionData?.duration ?? Duration.zero,
                position: positionData?.position ?? Duration.zero,
                bufferedPosition:
                    positionData?.bufferedPosition ?? Duration.zero,
                onChangeEnd: player.seek,
                onChanged: (v) {},
              );
            },
          ),
        ],
      ),
    );
  }

  Stream<PositionDataModel> get positionDataStream => rx_dart.Rx.combineLatest3<
          Duration, Duration, Duration?, PositionDataModel>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, bufferedPosition, duration) => PositionDataModel(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
