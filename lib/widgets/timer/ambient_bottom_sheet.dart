import 'package:comp4521_gp4_accelyst/models/timer/ambient_sound.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:flutter/material.dart';

class AmbientBottomSheet extends StatefulWidget {
  /// Initial index of ambient sound to be selected.
  final int initialIndex;

  /// Additional callback after user presses a button.
  final void Function(int) onPressed;

  const AmbientBottomSheet({
    Key? key,
    required this.initialIndex,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<AmbientBottomSheet> createState() => _AmbientBottomSheetState();
}

class _AmbientBottomSheetState extends State<AmbientBottomSheet> {
  late int activeIndex;

  @override
  void initState() {
    super.initState();
    activeIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkThemeData(context),
      child: Material(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Ambient Sound",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 25),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Disable scroll
                children: ambientSounds.map((sound) {
                  int index =
                      ambientSounds.indexWhere((e) => sound.label == e.label);
                  return TextButton(
                    onPressed: () {
                      setState(() => activeIndex = index);
                      widget.onPressed(activeIndex);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          sound.icon,
                          size: 28,
                        ),
                        const SizedBox(height: 8),
                        Text(sound.label),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor:
                          index == activeIndex ? Colors.white12 : null,
                    ),
                  );
                }).toList(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
