import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:flutter/material.dart';

enum PlayerStatus {
  play,
  pause,
  // stop,
}

class VocabAudioPlayer extends StatefulWidget {
  final String vocabID;
  VocabAudioPlayer({
    Key? key,
    required this.vocabID,
  }) : super(key: key);

  @override
  State<VocabAudioPlayer> createState() => _VocabAudioPlayerState();
}

class _VocabAudioPlayerState extends State<VocabAudioPlayer> {
  PlayerStatus playerStatus = PlayerStatus.pause;

  IconData getIcon() {
    switch (playerStatus) {
      case PlayerStatus.play:
        return Icons.play_arrow;
      case PlayerStatus.pause:
        return Icons.pause;
      // case PlayerStatus.stop:
      //   return Icons.square;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              getIcon(),
              // size: 25,
            ),
            onPressed: () {
              setState(() {
                switch (playerStatus) {
                  case PlayerStatus.play:
                    playerStatus = PlayerStatus.pause;
                    break;
                  case PlayerStatus.pause:
                    playerStatus = PlayerStatus.play;
                    break;
                }
              });
            },
            iconSize: 25,
            enableFeedback: false,
          ),
          Text(
            "0:30/1:34",
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
