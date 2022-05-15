import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_item.dart';
import 'package:comp4521_gp4_accelyst/utils/constants/theme_data.dart';
import 'package:comp4521_gp4_accelyst/utils/services/http_service.dart';
import 'package:comp4521_gp4_accelyst/widgets/roman_room/photo_grid/photo_grid.dart';
import 'package:flutter/material.dart';

final roomData = RomanRoom(
  id: "my-room",
  name: "My Roman Room",
  description: "Sample Text",

  // TODO: Delete the following placeholder items if no longer needed.
  items: List.generate(
    9,
    (index) => RomanRoomItem(
      id: "picsum$index",
      description: "Sample description of item ${index + 1}",
      url: "https://picsum.photos/id/${index * 5}/1280/720.jpg",
    ),
  ),
);

class RoomRecall extends StatefulWidget {
  const RoomRecall({Key? key}) : super(key: key);

  @override
  State<RoomRecall> createState() => _RoomRecallState();
}

class _RoomRecallState extends State<RoomRecall> {
  /// Data of roman room items to be rendered. We don't directly render roomData.items because
  /// users may shuffle the order of items.
  List<RomanRoomItem> itemsData = List.from(roomData.items);

  bool _previewItems = true;
  bool _randomOrder = false;

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

  @override
  void initState() {
    super.initState();

    // Downloads placeholder images
    getImagesFromRomanRoomItem(
      data: roomData.items,
      saveSuccessCallback: (index, updatedImageData) {
        if (mounted) {
          setState(() => itemsData[index] = updatedImageData);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomData.name),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          // Using slivers allow us to scroll the list and grid views together
          // See https://api.flutter.dev/flutter/widgets/SliverList-class.html
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Description"),
              keyboardType: TextInputType.multiline,
              maxLines: null, // Take as much lines as the input value
              initialValue: roomData.description,
              readOnly: true,
            ),
            const SizedBox(height: 15),
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
            const SizedBox(height: 25),
            Expanded(
              child: SingleChildScrollView(
                child: PhotoGrid(
                  roomData: roomData,
                  itemsData: itemsData,
                  itemCount: roomData.items.length,
                  showImageThumbnail: _previewItems,
                  onReorder: _onReorder,
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
