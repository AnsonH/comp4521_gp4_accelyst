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
  // /// Audio path
  // String vocabAudioPath = StorageService.directory.path;
  //
  // /// Whether audio is being played or paused
  // RecorderStatus _playerStatus = RecorderStatus.notReady;
  //
  // /// Audio player
  // AudioPlayer _audioPlayer = AudioPlayer();
  //
  // /// Audio length
  // Duration length = Duration(milliseconds: 1);
  //
  // /// Audio progress bar position
  // Duration pos = const Duration(milliseconds: 0);
  //
  // @override
  // void initState() {
  //   _audioPlayer.onDurationChanged.listen((Duration d) => () {
  //         length = d;
  //         setState(() {});
  //       });
  //   Future.delayed(Duration.zero, () async {
  //     await _initialize();
  //   });
  //
  //   super.initState();
  // }
  //
  // Future<void> _getAudioDuration() async {
  //   try {
  //     await _audioPlayer.play(vocabAudioPath, isLocal: true);
  //     final duration = await _audioPlayer.getDuration();
  //     await _audioPlayer.stop();
  //     setState(() {
  //       length = Duration(milliseconds: duration);
  //     });
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
  //
  // Future<void> _initialize() async {
  //   vocabAudioPath += "/vocab-list-data/" + widget.vocabAudioPath;
  //   await _getAudioDuration();
  //   await _audioPlayer.setReleaseMode(ReleaseMode.STOP);
  //   int result = await _audioPlayer.setUrl(vocabAudioPath);
  //   if (result != 1) {
  //     showSnackbarMessage(context,
  //         success: false, message: "Unable to load story.");
  //     setState(() {
  //       _playerStatus = PlayerStatus.error;
  //     });
  //     return;
  //   }
  //   debugPrint("Duration: " + length.inMilliseconds.toString());
  //   _audioPlayer.onAudioPositionChanged.listen((Duration p) async {
  //     length = Duration(milliseconds: await _audioPlayer.getDuration());
  //     setState(() {
  //       pos = p;
  //     });
  //   });
  //   _audioPlayer.onPlayerCompletion.listen((event) {
  //     setState(() {
  //       pos = Duration(milliseconds: 0);
  //       _playerStatus = PlayerStatus.pause;
  //     });
  //   });
  //
  //   setState(() {
  //     _playerStatus = PlayerStatus.pause;
  //   });
  // }
  //
  // /// Helper function to choose the correct button icon for use
  // IconData getIcon() {
  //   switch (_playerStatus) {
  //     case PlayerStatus.notReady:
  //       return Icons.pending;
  //     case PlayerStatus.play:
  //       // Lets user click on pause to pause
  //       return Icons.pause;
  //     case PlayerStatus.pause:
  //       // Lets user click on play to play
  //       return Icons.play_arrow;
  //     // case PlayerStatus.stop:
  //     //   return Icons.square;
  //     default:
  //       return Icons.error_outline;
  //   }
  // }
  //
  // Future<int> _playAudio() async {
  //   return await _audioPlayer.resume();
  // }
  //
  // Future<int> _pauseAudio() async {
  //   return await _audioPlayer.pause();
  // }
  //
  // Future<int> _slideAudio(double sliderPos) async {
  //   // TODO
  //   pos = Duration(milliseconds: sliderPos.toInt());
  //   return await _audioPlayer.seek(pos);
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     color: secondaryColor,
  //     child: (_playerStatus == PlayerStatus.notReady)
  //         ? const Text("Loading story ...")
  //         : (_playerStatus == PlayerStatus.error)
  //             ? const Text("Unable to load story.")
  //             : Row(
  //                 children: [
  //                   IconButton(
  //                     icon: Icon(
  //                       getIcon(),
  //                       // size: 25,
  //                     ),
  //                     onPressed: () {
  //                       setState(() {
  //                         switch (_playerStatus) {
  //                           // Originally is play, switch to pause
  //                           case PlayerStatus.play:
  //                             _playerStatus = PlayerStatus.pause;
  //                             _pauseAudio();
  //                             break;
  //                           // Originally is pause, switch to play
  //                           case PlayerStatus.pause:
  //                             _playerStatus = PlayerStatus.play;
  //                             _playAudio();
  //                             break;
  //                           default:
  //                         }
  //                       });
  //                     },
  //                     iconSize: 25,
  //                     enableFeedback: false,
  //                   ),
  //                   Text(
  //                     "${pos.inMinutes}:${((pos.inSeconds < 10) ? "0" : "") + pos.inSeconds.toString()}/${length.inMinutes}:${((length.inSeconds < 10) ? "0" : "") + length.inSeconds.toString()}",
  //                     style: TextStyle(fontSize: 15),
  //                   ),
  //                   Expanded(
  //                     child: Slider(
  //                       value: pos.inMilliseconds.toDouble(),
  //                       max: length.inMilliseconds.toDouble(),
  //                       onChanged: (double sliderPos) {
  //                         _slideAudio(sliderPos);
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //   );
  // }
  //
  // @override
  // void dispose() {
  //   _audioPlayer.stop();
  //   _audioPlayer.release();
  //   _audioPlayer.dispose();
  //   super.dispose();
  // }
}
