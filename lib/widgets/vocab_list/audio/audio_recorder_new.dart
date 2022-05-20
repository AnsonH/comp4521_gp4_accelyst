import 'dart:async';

import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:comp4521_gp4_accelyst/utils/services/local_storage_service.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/show_snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

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
  // Duration recordDuration = const Duration(milliseconds: 0);
  Timer? _timer;
  Timer? _ampTimer;
  int _recordDuration = 0;

  /// Recorder
  final _audioRecorder = Record();

  Amplitude? _amplitude;

  @override
  void initState() {
    super.initState();
  }

  /// Helper function to choose the correct button icon for use
  IconData getIcon() {
    switch (_recorderStatus) {
      case RecorderStatus.notReady:
        return Icons.pending;
      case RecorderStatus.recording:
        // Lets user click on stop to stop recording
        return Icons.stop;
      case RecorderStatus.idle:
        // Lets user click on record to start recording
        return Icons.mic;
      default:
        return Icons.error_outline;
    }
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start();
        if (await _audioRecorder.isRecording()) {
          setState(() {
            _recorderStatus = RecorderStatus.recording;
          });
        }
        _startTimer();
      } else {
        debugPrint("Error: Microphone Permission Required");
        setState(() {
          _recorderStatus = RecorderStatus.error;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _recorderStatus = RecorderStatus.error;
      });
    }
  }

  Future<String?> _stopRecording() async {
    _timer?.cancel();
    _ampTimer?.cancel();

    final path = await _audioRecorder.stop();

    debugPrint(path!);

    // TODO: save audio to mp3

    setState(() {
      _recorderStatus = RecorderStatus.idle;
    });
  }

  void _startTimer() {
    _recordDuration = 0;

    _timer?.cancel();
    _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        _recordDuration++;
      });
    });

    _ampTimer =
        Timer.periodic(const Duration(milliseconds: 200), (Timer t) async {
      _amplitude = await _audioRecorder.getAmplitude();
      setState(() {});
    });
  }

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
                              _stopRecording();
                              break;
                            // Originally is idle, switch to start recording
                            case RecorderStatus.idle:
                              _startRecording();
                              break;
                            default:
                          }
                        });
                      },
                      iconSize: 50,
                      enableFeedback: false,
                    ),
                    Text(
                      "${_recordDuration / 60}:${((_recordDuration < 10) ? "0" : "") + _recordDuration.toString()}",
                      style: TextStyle(fontSize: 40),
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

  @override
  void dispose() {
    _timer?.cancel();
    _ampTimer?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }
}
