import 'package:audioplayers/audioplayers.dart';

/// A helper class for audio playback.
///
/// To play several audios at the same time, create multiple instances of this class.
class AudioPlayerService {
  late AudioPlayer _audioPlayer;

  /// The [AudioCache] class helps us play local assets stored in the `assets/` folder.
  late AudioCache _audioCache;

  /// Creates a new instance of a helper class for audio playback.
  AudioPlayerService() {
    _audioPlayer = AudioPlayer();
    _audioCache = AudioCache(fixedPlayer: _audioPlayer);
  }

  /// Plays a local asset audio file.
  ///
  /// Suppose your audio file is stored in `assets/audio/foo.mp3`.
  /// 1. Update `pubspec.yaml`:
  ///    ```yaml
  ///    flutter:
  ///      assets:
  ///        - assets/audio/
  ///    ```
  /// 2. Pass `"audio/foo.mp3"` to [assetPath]. For example:
  ///    ```dart
  ///    final audioPlayer = AudioPlayerService();
  ///    audioPlayer.playAsset("audio/foo.mp3");
  ///    ```
  void playAsset(
    String assetPath, {
    bool loop = false,
    double volume = 1.0,
  }) {
    if (loop) {
      _audioCache.loop(assetPath, volume: volume);
    } else {
      _audioCache.play(assetPath, volume: volume);
    }
  }

  void stop() {
    _audioPlayer.stop();
  }
}
