import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_item.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_storage.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/roman_room/room_edit.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:comp4521_gp4_accelyst/widgets/roman_room/photo_grid/photo_grid.dart';
import 'package:flutter/material.dart';

class RoomRecall extends StatefulWidget {
  /// The UUID of an existing roman room that we wish to recall.
  final String uuid;

  const RoomRecall({
    Key? key,
    required this.uuid,
  }) : super(key: key);

  @override
  State<RoomRecall> createState() => _RoomRecallState();
}

class _RoomRecallState extends State<RoomRecall> {
  final _descriptionController = TextEditingController();

  // To be updated in _loadRomanRoomData()
  RomanRoom roomData = RomanRoom(
    id: "placeholder-id",
    items: [],
  );

  /// Data of roman room items to be rendered. We don't directly render roomData.items
  /// because users may shuffle the order of items. Hence, we deep copies that list.
  late List<RomanRoomItem> itemsData = List.from(roomData.items);

  bool _previewItems = true;
  bool _randomOrder = false;

  void _loadRomanRoomData() {
    late final RomanRoomStorage rrStorage;
    rrStorage = RomanRoomStorage(
      widget.uuid,
      callback: () async {
        try {
          final json = await rrStorage.read();
          setState(() {
            roomData = RomanRoom.fromJson(json);
            itemsData = List.from(roomData.items);
          });
          _updateDescriptionTextField();
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    // Also update the roman room data
    final element = roomData.items.removeAt(oldIndex);
    roomData.items.insert(newIndex, element);

    setState(() {
      final element = itemsData.removeAt(oldIndex);
      itemsData.insert(newIndex, element);
    });
  }

  void _randomizeOrder(bool randomize) {
    setState(() {
      if (randomize) {
        itemsData.shuffle();
      } else {
        itemsData = List.from(roomData.items);
      }

      _randomOrder = randomize;
    });
  }

  void _updateDescriptionTextField() {
    _descriptionController.text = roomData.description;
  }

  @override
  void initState() {
    super.initState();
    _loadRomanRoomData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomData.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: "Edit this room",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => RoomEdit(
                    uuid: roomData.id,
                  ),
                ),
              ).then((_) => _loadRomanRoomData());
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 16),
        child: Column(
          // Using slivers allow us to scroll the list and grid views together
          // See https://api.flutter.dev/flutter/widgets/SliverList-class.html
          children: [
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
              keyboardType: TextInputType.multiline,
              maxLines: null, // Take as much lines as the input value
              readOnly: true,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _labelledSwitch(
                  value: _previewItems,
                  label: "Preview Items",
                  onChanged: (value) {
                    setState(() => _previewItems = value);
                  },
                ),
                _labelledSwitch(
                  value: _randomOrder,
                  label: "Shuffle Items",
                  onChanged: _randomizeOrder,
                ),
              ],
            ),
            const SizedBox(height: 20),
            roomData.items.isEmpty
                ? Container(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      "This room has no items.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                  )
                : Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: PhotoGrid(
                          roomData: roomData,
                          itemsData: itemsData,
                          showImageThumbnail: _previewItems,
                          onReorder: _onReorder,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }
}

Widget _labelledSwitch({
  required bool value,
  required String label,
  required void Function(bool) onChanged,
}) {
  return Row(
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      Switch(
        value: value,
        onChanged: onChanged,
        activeColor: primaryColor,
      ),
    ],
  );
}
