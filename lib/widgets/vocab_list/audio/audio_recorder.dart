import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:comp4521_gp4_accelyst/utils/services/local_storage_service.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/show_snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

/// RecorderStatus enum to signify audio play/pause/stop status
/// - [play]: audio is being played
/// - [pause]: audio is on pause
enum RecorderStatus {
  notReady,
  recording,
  idle,
  error,
}

class VocabAudioRecorder extends StatefulWidget {
  final String vocabAudioPath;
  VocabAudioRecorder({
    Key? key,
    required this.vocabAudioPath,
  }) : super(key: key);

  @override
  State<VocabAudioRecorder> createState() => _VocabAudioRecorderState();
}

class _VocabAudioRecorderState extends State<VocabAudioRecorder> {
  /// Audio path
  String vocabAudioPath = StorageService.directory.path;

  /// Whether audio is being played or paused
  RecorderStatus _recorderStatus = RecorderStatus.notReady;

  /// Record audio duration
  Duration pos = const Duration(milliseconds: 0);

  /// Recorder
  // AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    vocabAudioPath += "/vocab-list-data/" + widget.vocabAudioPath;

    setState(() {
      // _recorderStatus = PlayerStatus.pause;
    });
  }

  /// Helper function to choose the correct button icon for use
  IconData getIcon() {
    switch (_recorderStatus) {
      // case PlayerStatus.notReady:
      //   return Icons.pending;
      // case PlayerStatus.play:
      //   // Lets user click on pause to pause
      //   return Icons.pause;
      // case PlayerStatus.pause:
      //   // Lets user click on play to play
      //   return Icons.play_arrow;
      // // case PlayerStatus.stop:
      // //   return Icons.square;
      default:
        return Icons.error_outline;
    }
  }

  Future<void> _recordAudio() async {}

  Future<void> _idleAudio() async {}

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      child: (_recorderStatus == RecorderStatus.notReady)
          ? const Text("Loading audio recorder ...")
          : (_recorderStatus == RecorderStatus.error)
              ? const Text("Unable to load recorder.")
              : Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        getIcon(),
                        // size: 25,
                      ),
                      onPressed: () {
                        setState(() {
                          switch (_recorderStatus) {
                            // Originally is recording, switch to idle
                            case RecorderStatus.recording:
                              _recorderStatus = RecorderStatus.idle;
                              _idleAudio();
                              break;
                            // Originally is idle, switch to start recording
                            case RecorderStatus.idle:
                              _recorderStatus = RecorderStatus.recording;
                              _recordAudio();
                              break;
                            default:
                          }
                        });
                      },
                      iconSize: 25,
                      enableFeedback: false,
                    ),
                    Text(
                      "${pos.inMinutes}:${((pos.inSeconds < 10) ? "0" : "") + pos.inSeconds.toString()}",
                      style: TextStyle(fontSize: 15),
                    ),
                    // Expanded(
                    //   child: Slider(
                    //     value: pos.inMilliseconds.toDouble(),
                    //     max: length.inMilliseconds.toDouble(),
                    //     onChanged: (double sliderPos) {
                    //       _slideAudio(sliderPos);
                    //     },
                    //   ),
                    // ),
                  ],
                ),
    );
  }

  // @override
  // void dispose() {
  //   _audioPlayer.stop();
  //   _audioPlayer.release();
  //   _audioPlayer.dispose();
  //   super.dispose();
  // }
}
