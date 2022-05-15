import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:flutter/material.dart';

/// A slider with labels.
class SliderWithLabel extends StatefulWidget {
  final String label;
  final int initialValue;

  final void Function(int)? onChanged;

  /// Called when the user is done selecting a new value for the slider.
  final void Function(int)? onChangeEnd;

  final int min;
  final int max;
  final int? divisions;
  final double verticalPadding;

  /// If false, it uses the secondary color (yellow).
  final bool usePrimaryColor;

  /// Add an icon at the left.
  final IconData? icon;

  /// Creates a slider with labels.
  const SliderWithLabel({
    Key? key,
    required this.label,
    required this.initialValue,
    this.onChanged,
    this.onChangeEnd,
    this.min = 1,
    this.max = 100,
    this.divisions,
    this.verticalPadding = 5.0,
    this.usePrimaryColor = true,
    this.icon,
  })  : assert(min <= initialValue && initialValue <= max),
        super(key: key);

  @override
  State<SliderWithLabel> createState() => _SliderWithLabelState();
}

class _SliderWithLabelState extends State<SliderWithLabel> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.verticalPadding),
      child: Row(
        children: [
          if (widget.icon != null)
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 16),
              child: Icon(
                widget.icon,
                size: 32,
                color: Colors.grey[600],
              ),
            ),
          Expanded(
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
                    if (widget.onChanged != null) {
                      widget.onChanged!(newValue.toInt());
                    }
                  },
                  onChangeEnd: (newValue) {
                    if (widget.onChangeEnd != null) {
                      widget.onChangeEnd!(newValue.toInt());
                    }
                  },
                  min: widget.min.toDouble(),
                  max: widget.max.toDouble(),
                  divisions: widget.divisions,
                  activeColor:
                      widget.usePrimaryColor ? primaryColor : secondaryColor,
                  inactiveColor: widget.usePrimaryColor
                      ? primaryColorOpaque
                      : secondaryColorOpaque,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
