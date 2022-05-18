import 'package:comp4521_gp4_accelyst/models/mnemonics_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// A section for a subject and its respective mnemonics tiles.
class SubjectMaterials extends StatelessWidget {
  final SubjectMaterialsData data;
  final void Function(int oldIndex, int newIndex) onReorder;

  /// Creates a section for a subject and its respective mnemonics tiles.
  const SubjectMaterials({
    Key? key,
    required this.data,
    required this.onReorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          data.subjectName,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Disable scroll
          children: [
            for (int index = 0; index < data.materials.length; ++index)
              Card(
                key: Key(data.materials[index].uuid),
                child: ListTile(
                  onTap: () {
                    // TODO: Open new page
                    debugPrint(data.materials[index].uuid);
                  },
                  title: Text(
                    data.materials[index].title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: data.materials[index].type == MnemonicType.romanRoom
                      ? const Icon(
                          Icons.meeting_room,
                          color: Colors.black,
                        )
                      : SvgPicture.asset("assets/icons/vocab_room.svg"),
                  minLeadingWidth: 20,
                  trailing: ReorderableDelayedDragStartListener(
                    index: index,
                    child: const Icon(Icons.drag_handle),
                  ),
                ),
              )
          ],
          onReorder: onReorder,
          buildDefaultDragHandles: false,
        ),
        const SizedBox(height: 35),
      ],
    );
  }
}
