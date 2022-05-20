// import 'dart:async';
//
// import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
// import 'package:comp4521_gp4_accelyst/utils/services/local_storage_service.dart';
// import 'package:comp4521_gp4_accelyst/widgets/core/show_snackbar_message.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:audio_session/audio_session.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// /// RecorderStatus enum to signify audio play/pause/stop status
// /// - [play]: audio is being played
// /// - [pause]: audio is on pause
// enum RecorderStatus {
//   notReady,
//   recording,
//   idle,
//   error,
// }
//
// class VocabAudioRecorder extends StatefulWidget {
//   final String vocabAudioPath;
//   VocabAudioRecorder({
//     Key? key,
//     required this.vocabAudioPath,
//   }) : super(key: key);
//
//   @override
//   State<VocabAudioRecorder> createState() => _VocabAudioRecorderState();
// }
//
// class _VocabAudioRecorderState extends State<VocabAudioRecorder> {
//   /// Audio path
//   String vocabAudioPath = StorageService.directory.path;
//
//   /// Whether audio is being played or paused
//   RecorderStatus _recorderStatus = RecorderStatus.notReady;
//
//   /// Record audio duration
//   Duration recordDuration = const Duration(milliseconds: 0);
//
//   /// Recorder
//   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//   StreamSubscription? _recorderSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     _initialize();
//   }
//
//   Future<void> _initialize() async {
//     vocabAudioPath += "/vocab-list-data/" + widget.vocabAudioPath;
//     try {
//       await _openRecorder();
//
//       _recorderSubscription = _recorder.onProgress!.listen((event) {
//         setState(() {
//           recordDuration = event.duration;
//         });
//       });
//
//       setState(() {
//         _recorderStatus = RecorderStatus.idle;
//       });
//     } catch (e) {
//       debugPrint(e.toString());
//       setState(() {
//         _recorderStatus = RecorderStatus.error;
//       });
//     }
//   }
//
//   /// Helper function to choose the correct button icon for use
//   IconData getIcon() {
//     switch (_recorderStatus) {
//       case RecorderStatus.notReady:
//         return Icons.pending;
//       case RecorderStatus.recording:
//         // Lets user click on stop to stop recording
//         return Icons.stop;
//       case RecorderStatus.idle:
//         // Lets user click on record to start recording
//         return Icons.mic;
//       default:
//         return Icons.error_outline;
//     }
//   }
//
//   void _cancelRecorderSubscriptions() {
//     if (_recorderSubscription != null) {
//       _recorderSubscription!.cancel();
//       _recorderSubscription = null;
//     }
//   }
//
//   Future<void> _openRecorder() async {
//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw RecordingPermissionException("Microphone permission required.");
//     }
//
//     await _recorder.openRecorder();
//     debugPrint(_recorder.toString());
//     if (!await _recorder.isEncoderSupported(Codec.mp3)) {
//       return;
//     }
//
//     final session = await AudioSession.instance;
//     await session.configure(AudioSessionConfiguration(
//       avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
//       avAudioSessionCategoryOptions:
//           AVAudioSessionCategoryOptions.allowBluetooth |
//               AVAudioSessionCategoryOptions.defaultToSpeaker,
//       avAudioSessionMode: AVAudioSessionMode.spokenAudio,
//       avAudioSessionRouteSharingPolicy:
//           AVAudioSessionRouteSharingPolicy.defaultPolicy,
//       avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
//       androidAudioAttributes: const AndroidAudioAttributes(
//         contentType: AndroidAudioContentType.speech,
//         flags: AndroidAudioFlags.none,
//         usage: AndroidAudioUsage.voiceCommunication,
//       ),
//       androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
//       androidWillPauseWhenDucked: true,
//     ));
//   }
//
//   Future<void> _startRecording() async {
//     await _recorder.startRecorder(
//       toFile: vocabAudioPath,
//       codec: Codec.mp3,
//     );
//     setState(() {});
//   }
//
//   Future<String?> _stopRecording() async {
//     await _recorder.closeRecorder();
//     String? result = await _recorder.stopRecorder();
//     showSnackbarMessage(context,
//         success: true, message: "Recording successfully saved!");
//     return result;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: secondaryColor,
//       child: (_recorderStatus == RecorderStatus.notReady)
//           ? const Text("Loading audio recorder ...")
//           : (_recorderStatus == RecorderStatus.error)
//               ? const Text("Unable to load recorder.")
//               : Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(
//                         getIcon(),
//                         // size: 25,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           switch (_recorderStatus) {
//                             // Originally is recording, switch to idle
//                             case RecorderStatus.recording:
//                               _recorderStatus = RecorderStatus.idle;
//                               _stopRecording();
//                               break;
//                             // Originally is idle, switch to start recording
//                             case RecorderStatus.idle:
//                               _recorderStatus = RecorderStatus.recording;
//                               _startRecording();
//                               break;
//                             default:
//                           }
//                         });
//                       },
//                       iconSize: 25,
//                       enableFeedback: false,
//                     ),
//                     Text(
//                       "${recordDuration.inMinutes}:${((recordDuration.inSeconds < 10) ? "0" : "") + recordDuration.inSeconds.toString()}",
//                       style: TextStyle(fontSize: 15),
//                     ),
//                     // Expanded(
//                     //   child: Slider(
//                     //     value: pos.inMilliseconds.toDouble(),
//                     //     max: length.inMilliseconds.toDouble(),
//                     //     onChanged: (double sliderPos) {
//                     //       _slideAudio(sliderPos);
//                     //     },
//                     //   ),
//                     // ),
//                   ],
//                 ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _recorder.stopRecorder();
//     _cancelRecorderSubscriptions();
//     _recorder.closeRecorder();
//     super.dispose();
//   }
// }
