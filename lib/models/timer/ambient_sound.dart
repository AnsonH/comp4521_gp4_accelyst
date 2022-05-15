import 'package:flutter/material.dart';

class AmbientSound {
  final String label;
  final IconData icon;

  /// Path to the audio file in `assets/` folder.
  ///
  /// If the file is stored in `assets/audio/foo.mp3`, [assetPath] should equal to
  /// `"audio/foo.mp3"`.
  final String assetPath;

  /// Sound volume from 0.0 to 1.0.
  final double volume;

  const AmbientSound({
    required this.label,
    required this.icon,
    required this.assetPath,
    this.volume = 1.0,
  });
}

const ambientSounds = <AmbientSound>[
  AmbientSound(
    label: "None",
    icon: Icons.volume_off,
    assetPath: "",
  ),
  AmbientSound(
    label: "Wave",
    icon: Icons.waves,
    assetPath: "audio/waves.mp3",
    volume: 0.5,
  ),
  AmbientSound(
    label: "Rain",
    icon: Icons.beach_access,
    assetPath: "audio/rain.mp3",
  ),
  AmbientSound(
    label: "Train",
    icon: Icons.train,
    assetPath: "audio/train.mp3",
  ),
  AmbientSound(
    label: "Cafe",
    icon: Icons.free_breakfast,
    assetPath: "audio/cafe.mp3",
  ),
];
