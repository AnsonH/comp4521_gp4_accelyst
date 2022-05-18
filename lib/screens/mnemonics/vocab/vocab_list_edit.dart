import 'package:comp4521_gp4_accelyst/models/vocab/vocab.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab_list.dart';
import 'package:flutter/material.dart';

class VocabListEdit extends StatefulWidget {
  // final String id;
  // const VocabListEdit({Key? key, required this.id}) : super(key: key);

  final VocabList vocablist;
  final void Function(
      {required String name,
      required String description,
      required List<Vocab> vocabs}) callback;
  const VocabListEdit({
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
  late final _descriptionController =
      TextEditingController(text: widget.vocablist.description);
  late List<Vocab> _vocabs = widget.vocablist.vocabs;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: const Text("Edit Vocab List"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // TODO: Save updated vocab list
              widget.callback(
                  name: _nameController.text,
                  description: _descriptionController.text,
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
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Vocab List Name"),
              readOnly: false,
              controller: _nameController,
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
                )),
                Expanded(
                    child: Text(
                  "Definition",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ],
            ),
            const SizedBox(height: 15),
            Column(
              children: widget.vocablist.vocabs
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
                            )),
                            Expanded(
                                child: Text(
                              vocab.definition,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )),
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
              },
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      ),
    );
  }
}
