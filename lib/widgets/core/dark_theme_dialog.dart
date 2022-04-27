import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:flutter/material.dart';

/// Shows a dark-themed dialog.
void showDarkThemeDialog({
  required BuildContext context,
  String? title,
  Widget? content,
  List<Widget>? actions,
}) {
  showDialog(
    context: context,
    builder: (context) => DarkThemeDialog(
      context: context,
      title: title,
      content: content,
      actions: actions,
    ),
  );
}

/// A dark-themed dialog box.
class DarkThemeDialog extends StatelessWidget {
  final BuildContext context;
  final String? title;
  final Widget? content;
  final List<Widget>? actions;

  /// Creates a dark-themed dialog box.
  const DarkThemeDialog({
    Key? key,
    required this.context,
    this.title,
    this.content,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkThemeData(context),
      child: AlertDialog(
        title: title != null ? Text(title!) : null,
        content: content,
        actions: actions,
      ),
    );
  }
}
