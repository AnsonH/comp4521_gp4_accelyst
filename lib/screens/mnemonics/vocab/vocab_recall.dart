import 'package:comp4521_gp4_accelyst/models/vocab/vocab.dart';
import 'package:comp4521_gp4_accelyst/models/vocab/vocab_list.dart';
import 'package:flutter/material.dart';

class VocabRecall extends StatefulWidget {
  final VocabList vocablist;
  VocabRecall({Key? key, required this.vocablist}) : super(key: key);

  @override
  State<VocabRecall> createState() => _VocabRecallState();
}

class _VocabRecallState extends State<VocabRecall> {
  late VocabList vocablist = widget.vocablist;
  late Vocab currentVocab = vocablist.vocabs[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Revision - ${vocablist.name}"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          // Using slivers allow us to scroll the list and grid views together
          // See https://api.flutter.dev/flutter/widgets/SliverList-class.html
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 40),
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute<void>(
                      //     builder: (BuildContext context) =>
                      //         const VocabListView(),
                      //   ),
                      // );
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
                    // children: getVocabList(),
                    ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
