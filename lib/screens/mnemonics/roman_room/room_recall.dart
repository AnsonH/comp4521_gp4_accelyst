import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_item.dart';
import 'package:comp4521_gp4_accelyst/utils/services/http_service.dart';
import 'package:comp4521_gp4_accelyst/widgets/roman_room/photo_grid/photo_grid.dart';
import 'package:flutter/material.dart';

class RoomRecall extends StatefulWidget {
  const RoomRecall({Key? key}) : super(key: key);

  @override
  State<RoomRecall> createState() => _RoomRecallState();
}

class _RoomRecallState extends State<RoomRecall> {
  final List<RomanRoomItem?> _imagesData = List.filled(gridItems.length, null);

  @override
  void initState() {
    super.initState();

    // Downloads placeholder images
    getImagesFromRomanRoomItem(
      data: gridItems,
      saveSuccessCallback: (index, updatedImageData) {
        if (mounted) {
          setState(() => _imagesData[index] = updatedImageData);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Revise Roman Room"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          // Using slivers allow us to scroll the list and grid views together
          // See https://api.flutter.dev/flutter/widgets/SliverList-class.html
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                TextFormField(
                  decoration: const InputDecoration(labelText: "Name"),
                  initialValue: "My Room",
                  readOnly: true,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Subject"),
                  initialValue: "COMP4521",
                  readOnly: true,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Description"),
                  keyboardType: TextInputType.multiline,
                  maxLines: null, // Take as much lines as the input value
                  initialValue: "Sample Text\nMiddle Text\nBottom Text",
                  readOnly: true,
                ),
                const SizedBox(height: 25),
                Text(
                  "Your Roman Room",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 10),
              ]),
            ),
            PhotoGrid(
              imagesData: _imagesData,
              imageCount: gridItems.length,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 30),
                Text(
                  "Room Objects",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: Delete the following placeholder items if no longer needed.
var gridItems = <RomanRoomItem>[
  RomanRoomItem(
    id: "item1",
    url: "https://picsum.photos/id/237/1280/720.jpg",
  ),
  RomanRoomItem(
    id: "item2",
    url: "https://picsum.photos/id/236/1280/720.jpg",
  ),
  RomanRoomItem(
    id: "item3",
    url: "https://picsum.photos/id/235/1280/720.jpg",
  ),
  RomanRoomItem(
    id: "item4",
    url: "https://picsum.photos/id/234/1280/720.jpg",
  ),
  RomanRoomItem(
    id: "item5",
    url: "https://picsum.photos/id/233/1280/720.jpg",
  ),
  RomanRoomItem(
    id: "item6",
    url: "https://picsum.photos/id/232/1280/720.jpg",
  ),
  RomanRoomItem(
    id: "item7",
    url: "https://picsum.photos/id/231/1280/720.jpg",
  ),
  RomanRoomItem(
    id: "item8",
    url: "https://picsum.photos/id/230/1280/720.jpg",
  ),
  RomanRoomItem(
    id: "item9",
    url: "https://picsum.photos/id/237/1280/720.jpg",
  ),
];
