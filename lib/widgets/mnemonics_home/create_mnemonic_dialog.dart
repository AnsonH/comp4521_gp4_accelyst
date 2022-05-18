import 'package:comp4521_gp4_accelyst/models/mnemonics/mnemonics_data.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Shows a dialog to let user pick whether to create a Roman Room or Vocab List.
///
/// This is called when pressing Mnemonics home page's floating action button.
Future<MnemonicType?> showCreateMnemonicDialog(BuildContext context) async {
  return showDialog<MnemonicType>(
    context: context,
    builder: (BuildContext context) => SimpleDialog(
      title: const Text("Select Type"),
      children: [
        SimpleDialogOption(
          child: Row(
            children: [
              Icon(Icons.meeting_room, color: primaryColor),
              const SizedBox(width: 10),
              Text(
                "Roman Room",
                style: TextStyle(fontSize: 16, color: primaryColor),
              ),
            ],
          ),
          onPressed: () {
            Navigator.pop(context, MnemonicType.romanRoom);
          },
        ),
        SimpleDialogOption(
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  "assets/icons/vocab_room.svg",
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Vocab List",
                style: TextStyle(fontSize: 16, color: primaryColor),
              ),
            ],
          ),
          onPressed: () {
            Navigator.pop(context, MnemonicType.vocabList);
          },
        ),
      ],
    ),
  );
}
