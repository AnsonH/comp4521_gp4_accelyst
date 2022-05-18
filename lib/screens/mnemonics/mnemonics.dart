import 'package:comp4521_gp4_accelyst/models/mnemonics_data.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/roman_room/room_edit.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/roman_room/room_recall.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/vocab/vocab.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:comp4521_gp4_accelyst/widgets/mnemonics_home/subject_materials.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Mnemonics extends StatefulWidget {
  const Mnemonics({Key? key}) : super(key: key);

  @override
  State<Mnemonics> createState() => _MnemonicsState();
}

class _MnemonicsState extends State<Mnemonics> {
  // TODO: Replace with data read from local storage
  final data = MnemonicsData([
    SubjectMaterialsData(
      subjectName: "History",
      materials: [
        MnemonicMaterial(
          type: MnemonicType.romanRoom,
          title: "World War 2 Timeline",
          uuid: const Uuid().v1(),
        ),
        MnemonicMaterial(
          type: MnemonicType.vocabList,
          title: "History vocab list",
          uuid: const Uuid().v1(),
        ),
      ],
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mnemonics"),
      ),
      backgroundColor: Colors.grey[200],
      drawer: const NavDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.4,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // TODO: Add new roman room or vocab list
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...data.subjectMaterials.map((subMaterials) {
                return SubjectMaterials(
                  data: subMaterials,
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final materials = subMaterials.materials;
                      final item = materials.removeAt(oldIndex);
                      materials.insert(newIndex, item);
                    });
                  },
                );
              }).toList(),
              // Temporary links
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const Text("Temporary links to forms:"),
                  ElevatedButton.icon(
                    label: const Text("Roman Room: Recall Objects"),
                    icon: const Icon(Icons.open_in_new),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const RoomRecall(),
                        ),
                      );
                    },
                  ),
                  ElevatedButton.icon(
                    label: const Text("Roman Room: Edit/Create New"),
                    icon: const Icon(Icons.open_in_new),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const RoomEdit(),
                        ),
                      );
                    },
                  ),
                  ElevatedButton.icon(
                    label: const Text("Vocabulary"),
                    icon: const Icon(Icons.open_in_new),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const VocabHome(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
