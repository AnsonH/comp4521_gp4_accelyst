import 'package:comp4521_gp4_accelyst/models/vocab/vocab.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab_list.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab_storage.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/vocab/vocab_list_edit.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/vocab/vocab_recall.dart';
import 'package:flutter/material.dart';

class VocabListView extends StatefulWidget {
  final VocabList vocablist;
  const VocabListView({
    Key? key,
    required this.vocablist,
  }) : super(key: key);

  @override
  State<VocabListView> createState() => _VocabListViewState();
}

class _VocabListViewState extends State<VocabListView> {
  late VocabList vocablist = widget.vocablist;
  late final _nameController = TextEditingController(text: vocablist.name);
  late final _subjectController =
      TextEditingController(text: vocablist.subject);
  late final _descriptionController =
      TextEditingController(text: vocablist.description);

  List<Widget> getVocabList() {
    List<Widget> childs = [];
    for (int i = 0; i < vocablist.vocabs.length; ++i) {
      childs.add(Row(
        children: [
          Expanded(
            child: Text(
              vocablist.vocabs[i].word,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: Text(
              vocablist.vocabs[i].definition,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
        mainAxisSize: MainAxisSize.max,
      ));
      childs.add(
        const SizedBox(height: 15),
      );
    }
    return childs;
  }

  void editList(
      {required String name,
      required String subject,
      required String description,
      required List<Vocab> vocabs}) {
    // TODO: Save vocab list to files
    setState(() {
      widget.vocablist.name = vocablist.name = name;
      _nameController.value = TextEditingValue(text: name);
      widget.vocablist.subject = vocablist.subject = subject;
      _subjectController.value = TextEditingValue(text: subject);
      widget.vocablist.description = vocablist.description = description;
      _descriptionController.value = TextEditingValue(text: description);
      widget.vocablist.vocabs = vocablist.vocabs = vocabs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vocabulary List"),
        actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: (value) {
                if (value.toString() == "edit") {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          // VocabListEdit(id: vocablist.id),
                          VocabListEdit(
                        isNewList: false,
                        uuid: vocablist.id,
                      ),
                    ),
                  ).then((_) async {
                    final storageService = VocabStorage(vocablist.id);
                    vocablist = VocabList.fromJson(await storageService.read());
                  }).then((_) {
                    setState(() {});
                  });
                }
                value = "";
              },
              offset: const Offset(0, 52),
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    child: Text("Edit"),
                    value: "edit",
                  ),
                ];
              })
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Vocab List Name"),
              controller: _nameController,
              readOnly: true,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(labelText: "Subject"),
              controller: _subjectController,
              readOnly: true,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(labelText: "Description"),
              keyboardType: TextInputType.multiline,
              maxLines: null, // Take as much lines as the input value
              controller: _descriptionController,
              readOnly: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                child: const Text("Revision"),
                onPressed: () {
                  if (vocablist.vocabs.length == 0) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          VocabRecall(vocablist: vocablist),
                    ),
                  );
                }),
            const SizedBox(height: 30),
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
              children: getVocabList(),
            ),
          ],
        ),
      ),
    );
  }
}
