import 'package:comp4521_gp4_accelyst/models/vocab/vocab_list.dart';
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
                          VocabListEdit(id: vocablist.id),
                    ),
                  );
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
        child: CustomScrollView(
          // Using slivers allow us to scroll the list and grid views together
          // See https://api.flutter.dev/flutter/widgets/SliverList-class.html
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: "Vocab List Name"),
                  initialValue: vocablist.name,
                  readOnly: true,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Description"),
                  keyboardType: TextInputType.multiline,
                  maxLines: null, // Take as much lines as the input value
                  initialValue: vocablist.description,
                  readOnly: true,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    child: const Text("Revision"),
                    onPressed: () {
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    Expanded(
                        child: Text(
                      "Definition",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  children: getVocabList(),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
