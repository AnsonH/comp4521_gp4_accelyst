import 'dart:convert';

import 'package:comp4521_gp4_accelyst/models/mnemonics/mnemonics_data.dart';
import 'package:comp4521_gp4_accelyst/models/mnemonics/mnemonics_storage.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab_list.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab_storage.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/vocab/vocab_edit.dart';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class VocabListEdit extends StatefulWidget {
  /// UUID of Vocab List
  final String uuid;

  /// True if we're creating a new vocab list. False if we're editing an existing room.
  final bool isNewList;

  /// Pass 2 arguments:
  /// - isNewList: true if we are creating a new vocab list, false if we are editing an existing vocab list
  /// - uuid: pass a new UUID instance if we are creating a new vocab list, pass existing UUID if editing an existing vocab list
  const VocabListEdit({Key? key, required this.isNewList, required this.uuid})
      : super(key: key);

  // VocabList vocablist;
  // final void Function(
  //     {required String name,
  //     required String subject,
  //     required String description,
  //     required List<Vocab> vocabs}) callback;
  // VocabListEdit({
  //   Key? key,
  //   required this.vocablist,
  //   required this.callback,
  // }) : super(key: key);

  @override
  State<VocabListEdit> createState() => _VocabListEditState();
}

class _VocabListEditState extends State<VocabListEdit> {
  // late final _nameController =
  //     TextEditingController(text: widget.vocablist.name);
  // late final _subjectController =
  //     TextEditingController(text: widget.vocablist.subject);
  // late final _descriptionController =
  //     TextEditingController(text: widget.vocablist.description);
  // late List<Vocab> _vocabs = [...widget.vocablist.vocabs];

  @override
  void initState() {
    super.initState();

    _initializeVocabListData();
  }

  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<Vocab> _vocabs = [];

  late VocabList vocabList;

  Future<void> _initializeVocabListData() async {
    if (!widget.isNewList) {
      // Load vocab list data from storage service
      final storageService = VocabStorage(widget.uuid);
      vocabList = VocabList.fromJson(await storageService.read());

      // Display correct values at each shit
      setState(() {
        _nameController.value = TextEditingValue(
          text: vocabList.name,
        );
        _subjectController.value = TextEditingValue(
          text: vocabList.subject,
        );
        _descriptionController.value = TextEditingValue(
          text: vocabList.description,
        );
        _vocabs = vocabList.vocabs;
      });
    }
  }

  void addVocab({required Vocab vocab}) {
    setState(() {
      _vocabs.add(vocab);
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final element = _vocabs.removeAt(oldIndex);
      _vocabs.insert(newIndex, element);
    });
  }

  void _saveVocabList(BuildContext context) {
    // Validate data
    if (_nameController.text.trim() == "" ||
        _subjectController.text.trim() == "" ||
        _vocabs.isEmpty) return;
    // TODO: Save updated vocab list
    vocabList = VocabList(
        id: widget.uuid,
        name: _nameController.text.trim(),
        subject: _subjectController.text.trim(),
        description: _descriptionController.text.trim(),
        vocabs: _vocabs);
    final String json = jsonEncode(vocabList);
    debugPrint(json);

    // Save to local storage
    final storageService = VocabStorage(vocabList.id);
    storageService.save(json);

    // Save to mnemonics list
    late final MnemonicsStorage mnemonicsStorage;
    mnemonicsStorage = MnemonicsStorage(callback: () {
      mnemonicsStorage.loadJsonData().then((mnemonicsData) {
        // Append this vocab list to the mnemonicsData
        mnemonicsData.appendNewMnemonic(
          subject: vocabList.subject,
          material: MnemonicMaterial(
            type: MnemonicType.vocabList,
            title: vocabList.name,
            uuid: vocabList.id,
          ),
        );

        // Update actual mnemonics.json
        final String updatedJson = jsonEncode(mnemonicsData);
        mnemonicsStorage.save(updatedJson);
      });
    });

    Navigator.pop(context); // Exit "Edit task" screen
    // if (!widget.isNewList) {
    //   Navigator.pop(context); // Exit "Vocab List View" screen
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: const Text("Edit Vocab List"),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveVocabList(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text("Delete vocab list?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialogue
                      // TODO: Delete the task
                      Navigator.pop(context); // Exit "Edit task" screen
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Name*"),
              readOnly: false,
              controller: _nameController,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(labelText: "Subject*"),
              readOnly: false,
              controller: _subjectController,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(labelText: "Description"),
              keyboardType: TextInputType.multiline,
              maxLines: null, // Take as much lines as the input value
              readOnly: false,
              controller: _descriptionController,
            ),
            const SizedBox(height: 20),
            Row(
              children: const <Widget>[
                Expanded(
                  child: Text(
                    "Words",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Definition",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Column(
              children: _vocabs
                  .map((Vocab vocab) => Column(children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                vocab.word,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                vocab.definition,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ]))
                  .toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Add Vocab"),
              onPressed: () {
                // Open Add Vocab page
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        // VocabListEdit(id: vocablist.id),
                        VocabEdit(
                      callback: addVocab,
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text("Delete Vocab"),
              onPressed: () {
                if (_vocabs.length == 0) return;
                setState(() {
                  _vocabs.removeLast();
                });
              },
            ),
          ],
          // crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
