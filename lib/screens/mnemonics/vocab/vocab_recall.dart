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
  int vocabIdx = 0;
  late Vocab currentVocab = vocablist.vocabs[vocabIdx];

  bool _showSegments = false;
  bool _showStory = false;
  bool _showDescription = false;
  bool _showAnswer = false;

  List<Widget> getVocabSegmentList() {
    List<Widget> childs = [];
    for (int i = 0; i < currentVocab.vocabSegments.length; ++i) {
      childs.add(Row(
        children: [
          Expanded(
            child: Text(
              currentVocab.vocabSegments[i].segment,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: Text(
              currentVocab.vocabSegments[i].word,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
        mainAxisSize: MainAxisSize.max,
      ));
    }
    return childs;
  }

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
                Text(
                  currentVocab.word,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
                ElevatedButton(
                  child: Text("${_showSegments ? "Hide" : "Show"} Segments"),
                  onPressed: () {
                    setState(() {
                      _showSegments = !_showSegments;
                    });
                  },
                ),
                Column(
                  children: _showSegments
                      ? [
                          Row(
                            children: const <Widget>[
                              Expanded(
                                  child: Text(
                                "Segment",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                              Expanded(
                                  child: Text(
                                "Word",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                          const SizedBox(height: 15),
                          ...getVocabSegmentList(),
                        ]
                      : [],
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    child: Text("${_showStory ? "Hide" : "Show"} Story"),
                    onPressed: () {
                      setState(() {
                        _showStory = !_showStory;
                      });
                    }),
                Column(
                  children: _showStory
                      ? [
                          Text("Story",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ]
                      : [],
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    child: Text(
                        "${_showDescription ? "Hide" : "Show"} Description"),
                    onPressed: () {
                      setState(() {
                        _showDescription = !_showDescription;
                      });
                    }),
                Column(
                  children: _showDescription
                      ? [
                          Text("Description",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(currentVocab.description),
                        ]
                      : [],
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    child: Text("${_showAnswer ? "Hide" : "Show"} Answer"),
                    onPressed: () {
                      setState(() {
                        _showAnswer = !_showAnswer;
                      });
                    }),
                const SizedBox(height: 15),
                Column(
                  children: _showAnswer
                      ? [
                          Text("Definition",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(currentVocab.definition),
                        ]
                      : [],
                ),
                ElevatedButton(
                    child: const Text("Next Word"),
                    onPressed: () {
                      setState(() {
                        _showSegments = false;
                        _showStory = false;
                        _showDescription = false;
                        _showAnswer = false;
                        ++vocabIdx;
                        if (vocabIdx == vocablist.vocabs.length) {
                          Navigator.pop(context);
                        } else {
                          currentVocab = vocablist.vocabs[vocabIdx];
                        }
                      });
                    }),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
