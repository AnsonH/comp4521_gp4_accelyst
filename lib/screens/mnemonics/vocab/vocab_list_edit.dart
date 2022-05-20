import 'dart:convert';

import 'package:comp4521_gp4_accelyst/models/mnemonics/mnemonics_data.dart';
import 'package:comp4521_gp4_accelyst/models/mnemonics/mnemonics_storage.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab_list.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab_storage.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/vocab/vocab_edit.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/show_snackbar_message.dart';

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
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final Vocab vocab = _vocabs.removeAt(oldIndex);
      _vocabs.insert(newIndex, vocab);
    });
  }

  void _saveVocabList(BuildContext context) async {
    // Validate data
    if (_nameController.text.trim() == "") {
      showSnackbarMessage(context,
          success: false, message: "Vocab list name is required!");
      return;
    }
    if (_subjectController.text.trim() == "") {
      showSnackbarMessage(context,
          success: false, message: "Vocab list subject is required!");
      return;
    }
    if (_vocabs.isEmpty) {
      showSnackbarMessage(context,
          success: false, message: "Vocab list must contain at least 1 vocab!");
      return;
    }
    // Save updated vocab list
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
    await storageService.save(json);

    // Save to mnemonics list
    final MnemonicsStorage mnemonicsStorage = MnemonicsStorage();
    final mnemonicsData = await mnemonicsStorage.loadJsonData();
    if (widget.isNewList) {
      // Append this vocab list to mnemonicsData
      mnemonicsData.appendNewMnemonic(
        subject: vocabList.subject,
        material: MnemonicMaterial(
          type: MnemonicType.vocabList,
          title: vocabList.name,
          uuid: vocabList.id,
        ),
      );
    } else {
      // Update mnemonicsData
      mnemonicsData.updateMaterial(
          uuid: widget.uuid,
          newSubject: _subjectController.text.trim(),
          newTitle: _nameController.text.trim());
    }

    // Update actual mnemonics.json
    final String updatedJson = jsonEncode(mnemonicsData);
    await mnemonicsStorage.save(updatedJson);

    // Show success snackbar
    showSnackbarMessage(context,
        success: true, message: "Vocab list saved successfully!");

    Navigator.pop(context); // Exit "Edit Vocab List" screen
  }

  Future<void> _deleteVocabList(BuildContext context) async {
    Navigator.pop(context); // Close dialogue

    // Delete the vocab list JSON file from vocab directory
    final vocabListStorage = VocabStorage(widget.uuid);
    await vocabListStorage.deleteVocabList();

    // Update mnemonics.json
    final mnemonicsStorage = MnemonicsStorage();
    final mnemonicsData = await mnemonicsStorage.loadJsonData();
    mnemonicsData.deleteMaterial(widget.uuid);
    final String updatedJson = jsonEncode(mnemonicsData);
    await mnemonicsStorage.save(updatedJson);

    Navigator.pop(context); // Exit "Edit Vocab List" screen
    Navigator.pop(context); // Exit "Vocab List View" screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: Text("${widget.isNewList ? "Add New" : "Edit"} Vocab List"),
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
          widget.isNewList
              ? Container()
              : IconButton(
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
                            _deleteVocabList(context);
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
            ReorderableListView(
              onReorder: _onReorder,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Disable scroll
              children: _vocabs
                  .map((Vocab vocab) => Card(
                        key: Key(vocab.id),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          child: Row(
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
                        ),
                      ))
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
