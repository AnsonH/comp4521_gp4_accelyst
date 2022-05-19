import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_item.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:comp4521_gp4_accelyst/widgets/roman_room/photo_grid/photo_grid.dart';
import 'package:flutter/material.dart';

class RoomRecall extends StatefulWidget {
  final RomanRoom roomData;

  const RoomRecall({
    Key? key,
    required this.roomData,
  }) : super(key: key);

  @override
  State<RoomRecall> createState() => _RoomRecallState();
}

class _RoomRecallState extends State<RoomRecall> {
  /// Data of roman room items to be rendered. We don't directly render widget.roomData.items
  /// because users may shuffle the order of items. Hence, we deep copies that list.
  late List<RomanRoomItem> itemsData = List.from(widget.roomData.items);

  bool _previewItems = true;
  bool _randomOrder = false;

  void _onReorder(int oldIndex, int newIndex) {
    // Also update the roman room data
    final element = widget.roomData.items.removeAt(oldIndex);
    widget.roomData.items.insert(newIndex, element);

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
        itemsData = List.from(widget.roomData.items);
      }

      _randomOrder = randomize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomData.name),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 16),
        child: Column(
          // Using slivers allow us to scroll the list and grid views together
          // See https://api.flutter.dev/flutter/widgets/SliverList-class.html
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Description"),
              keyboardType: TextInputType.multiline,
              maxLines: null, // Take as much lines as the input value
              initialValue: widget.roomData.description,
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
            widget.roomData.items.isEmpty
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
                          roomData: widget.roomData,
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
