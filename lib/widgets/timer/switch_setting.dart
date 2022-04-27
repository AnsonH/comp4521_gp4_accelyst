import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:flutter/material.dart';

/// A switch for setting a single timer property.
///
/// It is used in the timer page's settings bottom sheet.
class SwitchSetting extends StatefulWidget {
  final String label;
  final bool initialValue;
  final void Function(bool) onChanged;

  /// Callback when pressing the info button.
  ///
  /// If set to null, the info button will be hidden.
  final void Function()? onPressedInfo;

  /// Creates a switch for setting a single timer property.
  const SwitchSetting({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.onPressedInfo,
  }) : super(key: key);

  @override
  State<SwitchSetting> createState() => _SwitchSettingState();
}

class _SwitchSettingState extends State<SwitchSetting> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                widget.label,
                style: const TextStyle(fontSize: 18),
              ),
              if (widget.onPressedInfo != null)
                IconButton(
                  onPressed: () {
                    widget.onPressedInfo!();
                  },
                  icon: const Icon(
                    Icons.info,
                    size: 20,
                  ),
                  splashRadius: 18,
                ),
            ],
          ),
          Switch(
            value: value,
            onChanged: (bool newValue) {
              setState(() => value = newValue);
              widget.onChanged(newValue);
            },
            activeColor: secondaryColor,
          ),
        ],
      ),
    );
  }
}
