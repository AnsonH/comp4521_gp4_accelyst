import 'package:flutter/material.dart';

/// An icon button for the "Timer" page.
class TimerIconButton extends StatelessWidget {
  /// Callback for pressing the button.
  ///
  /// Pass `null` to this parameter to disable the button.
  final void Function()? onPressed;

  final IconData icon;

  /// Whether the button has a grayish background.
  final bool hasBackground;

  /// Creates an icon button for the "Timer" page.
  const TimerIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.hasBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // IconButton is not used because tapping it will not show a ripple. This is expected behavior
    // since the ripple will be hidden if the container has a background image.
    // See: https://github.com/flutter/flutter/issues/3782#issuecomment-217566214
    return ElevatedButton(
      child: Icon(icon, size: 32),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.all(hasBackground ? 12 : 16),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(const CircleBorder()),
        elevation: MaterialStateProperty.all<double>(0), // Removes shadow

        // Makes sure that button has transparent background even when disabled
        backgroundColor: MaterialStateProperty.all<Color>(hasBackground
            ? const Color.fromARGB(255, 83, 86, 108)
            : Colors.transparent),
      ),
      onPressed: onPressed,
    );
  }
}
