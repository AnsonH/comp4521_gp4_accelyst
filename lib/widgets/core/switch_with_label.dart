import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:flutter/material.dart';

/// A switch with label.
class SwitchWithLabel extends StatefulWidget {
  final String label;
  final bool initialValue;
  final void Function(bool) onChanged;

  /// Callback when pressing the info button.
  ///
  /// If set to null, the info button will be hidden.
  final void Function()? onPressedInfo;

  /// If false, it uses the secondary color (yellow).
  final bool usePrimaryColor;

  /// Add an icon at the left.
  final IconData? icon;

  /// Creates a switch with label.
  const SwitchWithLabel({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.onPressedInfo,
    this.usePrimaryColor = true,
    this.icon,
  }) : super(key: key);

  @override
  State<SwitchWithLabel> createState() => _SwitchWithLabelState();
}

class _SwitchWithLabelState extends State<SwitchWithLabel> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    widget.icon,
                    size: 32,
                    color: Colors.grey[600],
                  ),
                ),
              const SizedBox(width: 12),
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
            activeColor: widget.usePrimaryColor ? primaryColor : secondaryColor,
          ),
        ],
      ),
    );
  }
}
