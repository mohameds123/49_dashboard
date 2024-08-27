import 'dart:async';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import '../../../../../../../main.dart';
import '../../../../../../data/model/chat_message_model.dart';

class MessageRecordWidget extends StatelessWidget {
  final ChatMessageModel chatMessage;

  const MessageRecordWidget({
    super.key,
    required this.chatMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 5),
        if (chatMessage.recordPlayerController != null)
          WaveBubble(
            playerController: chatMessage.recordPlayerController!,
            isPlaying: chatMessage.recordPlayerController!.playerState !=
                PlayerState.stopped,
            onTap: _playOrPausePlayer,
          ),
      ],
    );
  }

  Future<void> _playOrPausePlayer() async {
    if (chatMessage.recordPlayerController!.playerState ==
        PlayerState.playing) {
      await chatMessage.recordPlayerController!.pausePlayer();
    } else {
      await chatMessage.recordPlayerController!
          .startPlayer(finishMode: FinishMode.pause);
    }
  }
}

class WaveBubble extends StatelessWidget {
  final PlayerController playerController;
  final VoidCallback onTap;
  final bool isPlaying;

  const WaveBubble({
    super.key,
    required this.playerController,
    required this.onTap,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(
            playerController.playerState == PlayerState.playing
                ? Icons.stop
                : playerController.playerState == PlayerState.paused
                    ? Icons.replay
                    : Icons.play_arrow,
          ),
          color: Colors.red,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        if (playerController.playerState != PlayerState.stopped)
          AudioFileWaveforms(
            size: Size(MediaQuery.of(context).size.width / 2.2, 50),
            playerController: playerController,
            density: 1.2,
            playerWaveStyle: const PlayerWaveStyle(
              scaleFactor: 0.8,
              fixedWaveColor: mainColor,
              liveWaveColor: Colors.red,
              waveCap: StrokeCap.butt,
            ),
          ),
      ],
    );
  }
}
