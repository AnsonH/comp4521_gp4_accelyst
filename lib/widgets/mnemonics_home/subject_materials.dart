import 'package:comp4521_gp4_accelyst/models/mnemonics/mnemonics_data.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_storage.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab_list.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab_storage.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/roman_room/room_recall.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/vocab/vocab_list.dart';
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

  void _openRomanRoomRecall(String uuid, BuildContext context) {
    late RomanRoomStorage rrStorage;
    rrStorage = RomanRoomStorage(
      uuid,
      callback: () async {
        final json = await rrStorage.read();
        final romanRoom = RomanRoom.fromJson(json);
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => RoomRecall(
              roomData: romanRoom,
            ),
          ),
        );
      },
    );
  }

  void _openVocabList(String uuid, BuildContext context) {
    late VocabStorage vocabListStorage;
    vocabListStorage = VocabStorage(
      uuid,
      callback: () async {
        final json = await vocabListStorage.read();
        final vocabList = VocabList.fromJson(json);
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => VocabListView(
              vocablist: vocabList,
            ),
          ),
        );
      },
    );
  }

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
                    final String uuid = data.materials[index].uuid;
                    if (data.materials[index].type == MnemonicType.romanRoom) {
                      _openRomanRoomRecall(uuid, context);
                    } else if (data.materials[index].type ==
                        MnemonicType.vocabList) {
                      _openVocabList(uuid, context);
                    }
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
