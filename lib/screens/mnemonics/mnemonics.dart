import 'package:comp4521_gp4_accelyst/models/mnemonics/mnemonics_data.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room.dart';
import 'package:comp4521_gp4_accelyst/models/roman_room/roman_room_storage.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab_list.dart';
import 'package:comp4521_gp4_accelyst/models/mnemonics/mnemonics_storage.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab_storage.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/roman_room/room_edit.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/roman_room/room_recall.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/vocab/vocab_list.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/vocab/vocab_list_edit.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:comp4521_gp4_accelyst/widgets/mnemonics_home/create_mnemonic_dialog.dart';
import 'package:comp4521_gp4_accelyst/widgets/mnemonics_home/subject_materials.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Mnemonics extends StatefulWidget {
  const Mnemonics({Key? key}) : super(key: key);

  @override
  State<Mnemonics> createState() => _MnemonicsState();
}

class _MnemonicsState extends State<Mnemonics> {
  // To be updated when we load from local storage
  MnemonicsData data = const MnemonicsData([]);

  // To be set in initState.
  late final MnemonicsStorage mnemonicsStorage;

  @override
  void initState() {
    super.initState();

    // Initializes storage service and load from JSON
    mnemonicsStorage = MnemonicsStorage(callback: () {
      loadMnemonicsData();
    });
  }

  /// Loads from the latest JSON data file and re-renders.
  Future<void> loadMnemonicsData() async {
    final MnemonicsData loadedData = await mnemonicsStorage.loadJsonData();
    setState(() => data = loadedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mnemonics"),
      ),
      backgroundColor: Colors.grey[200],
      drawer: const NavDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.4,
      // Button to create new mnemonic material
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // Show dialog to let users choose mnemonic type
          final MnemonicType? type = await showCreateMnemonicDialog(context);
          switch (type) {
            case MnemonicType.romanRoom:
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const RoomEdit(
                    isNewRoom: true,
                  ),
                ),
              ).then((_) => loadMnemonicsData());
              break;
            case MnemonicType.vocabList:
              // TODO: Open create new vocab list page
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => VocabListEdit(
                    isNewList: true,
                    uuid: Uuid().v1(),
                  ),
                ),
              ).then((_) => loadMnemonicsData());
              break;
            default:
              return;
          }
        },
        heroTag: null,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: (data.subjectMaterials.isEmpty)
            ? Column(
                children: const [
                  Center(
                    child: Text(
                      "Press the + button to add new study materials!",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )
            : SingleChildScrollView(
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

                            // Save to mnemonics.json
                            mnemonicsStorage.saveToJson(data);
                          },
                          onTapTile: (MnemonicType type, String uuid,
                              BuildContext context) async {
                            switch (type) {
                              case MnemonicType.romanRoom:
                                final rrStorage = RomanRoomStorage(uuid);
                                final json = await rrStorage.read();
                                final romanRoom = RomanRoom.fromJson(json);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (context) => RoomRecall(
                                      uuid: romanRoom.id,
                                    ),
                                  ),
                                ).then((_) => loadMnemonicsData());
                                break;
                              case MnemonicType.vocabList:
                                final vocabListStorage = VocabStorage(uuid);
                                final json = await vocabListStorage.read();
                                final vocabList = VocabList.fromJson(json);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (context) =>
                                        VocabListView(vocablist: vocabList),
                                  ),
                                ).then((_) => loadMnemonicsData());
                                break;
                            }
                          });
                    }).toList(),
                  ],
                ),
              ),
      ),
    );
  }
}
