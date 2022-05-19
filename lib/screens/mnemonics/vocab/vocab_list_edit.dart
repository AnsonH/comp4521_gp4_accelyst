import 'package:comp4521_gp4_accelyst/models/vocab/vocab.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab_list.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/vocab/vocab_edit.dart';
import 'package:flutter/material.dart';

class VocabListEdit extends StatefulWidget {
  // final String id;
  // const VocabListEdit({Key? key, required this.id}) : super(key: key);

  VocabList vocablist;
  final void Function(
      {required String name,
      required String subject,
      required String description,
      required List<Vocab> vocabs}) callback;
  VocabListEdit({
    Key? key,
    required this.vocablist,
    required this.callback,
  }) : super(key: key);

  @override
  State<VocabListEdit> createState() => _VocabListEditState();
}

class _VocabListEditState extends State<VocabListEdit> {
  late final _nameController =
      TextEditingController(text: widget.vocablist.name);
  late final _subjectController =
      TextEditingController(text: widget.vocablist.subject);
  late final _descriptionController =
      TextEditingController(text: widget.vocablist.description);
  late List<Vocab> _vocabs = [...widget.vocablist.vocabs];

  @override
  void dispose() {
    _nameController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
    _vocabs = widget.vocablist.vocabs;
    super.dispose();
  }

  void addVocab({required Vocab vocab}) {
    setState(() {
      _vocabs.add(vocab);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: const Text("Edit Vocab List"),
        leading: BackButton(
          onPressed: () {
            _vocabs = widget.vocablist.vocabs;
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (_nameController.text.trim() == "" ||
                  _subjectController.text.trim() == "") return;
              // TODO: Save updated vocab list
              widget.callback(
                  name: _nameController.text.trim(),
                  subject: _subjectController.text.trim(),
                  description: _descriptionController.text.trim(),
                  vocabs: _vocabs);
              Navigator.pop(context); // Exit "Edit task" screen
            },
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
              decoration: const InputDecoration(labelText: "Vocab List Name"),
              readOnly: false,
              controller: _nameController,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(labelText: "Subject"),
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
}
