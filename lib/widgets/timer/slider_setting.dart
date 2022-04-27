import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:flutter/material.dart';

/// A slider for setting a single timer property.
///
/// It is used in the timer page's settings bottom sheet.
class SliderSetting extends StatefulWidget {
  final String label;
  final int initialValue;
  final void Function(int) onChanged;
  final int min;
  final int max;

  /// Creates a slider for setting a single timer property.
  const SliderSetting({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.min = 1,
    this.max = 100,
  })  : assert(min <= initialValue && initialValue <= max),
        super(key: key);

  @override
  State<SliderSetting> createState() => _SliderSettingState();
}

class _SliderSettingState extends State<SliderSetting> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  value.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Slider(
            value: value.toDouble(),
            onChanged: (newValue) {
              setState(() => value = newValue.toInt());
              widget.onChanged(newValue.toInt());
            },
            min: widget.min.toDouble(),
            max: widget.max.toDouble(),
            activeColor: secondaryColor,
            inactiveColor: secondaryColorOpaque,
          ),
        ],
      ),
    );
  }
}
