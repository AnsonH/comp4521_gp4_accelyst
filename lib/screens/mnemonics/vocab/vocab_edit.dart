import 'package:comp4521_gp4_accelyst/models/vocab/vocab.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/show_snackbar_message.dart';
import 'package:comp4521_gp4_accelyst/widgets/vocab_list/audio/audio_recorder_new.dart';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class VocabEdit extends StatefulWidget {
  // final String id;
  // const VocabListEdit({Key? key, required this.id}) : super(key: key);

  final void Function({required Vocab vocab}) callback;
  const VocabEdit({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  State<VocabEdit> createState() => _VocabEditState();
}

class _VocabEditState extends State<VocabEdit> {
  final String id = const Uuid().v1();
  final _wordController = TextEditingController();
  final _subjectController = TextEditingController();
  final _definitionController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<List<TextEditingController>> _vocabSegmentsControllers = [];

  @override
  void dispose() {
    _wordController.dispose();
    _subjectController.dispose();
    _definitionController.dispose();
    _descriptionController.dispose();
    _vocabSegmentsControllers
        .forEach((List<TextEditingController> controllerPair) {
      controllerPair.forEach((TextEditingController controller) {
        controller.dispose();
      });
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: const Text("Add Vocab"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (_wordController.text.trim() == "") {
                showSnackbarMessage(context,
                    success: false, message: "Vocab is required!");
                return;
              }
              if (_definitionController.text.trim() == "") {
                showSnackbarMessage(context,
                    success: false, message: "Definition is required!");
                return;
              }
              // TODO: Add new vocab
              widget.callback(
                  vocab: Vocab(
                      id: id,
                      word: _wordController.text.trim(),
                      definition: _definitionController.text.trim(),
                      description: _descriptionController.text.trim(),
                      vocabSegments: _vocabSegmentsControllers
                          .map((List<TextEditingController> controllerPair) =>
                              VocabSegment(
                                  segment: controllerPair[0].text.trim(),
                                  word: controllerPair[1].text.trim()))
                          .toList()));
              showSnackbarMessage(context,
                  success: true, message: "Vocab added successfully!");
              Navigator.pop(context); // Exit "Edit task" screen
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.delete),
          //   onPressed: () => showDialog(
          //     context: context,
          //     builder: (BuildContext context) => AlertDialog(
          //       title: const Text("Delete vocab list?"),
          //       actions: <Widget>[
          //         TextButton(
          //           onPressed: () => Navigator.pop(context),
          //           child: const Text('Cancel'),
          //         ),
          //         TextButton(
          //           onPressed: () {
          //             Navigator.pop(context); // Close dialogue
          //             // TODOo: Delete the task
          //             Navigator.pop(context); // Exit "Edit task" screen
          //           },
          //           child: const Text('Delete'),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Vocab*"),
              readOnly: false,
              controller: _wordController,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(labelText: "Definition*"),
              keyboardType: TextInputType.multiline,
              maxLines: null, // Take as much lines as the input value
              readOnly: false,
              controller: _definitionController,
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
            const Text("Story",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            // Story audio
            VocabAudioRecorder(vocabAudioPath: "audio/$id.mp3"),
            const SizedBox(height: 20),
            Row(
              children: const <Widget>[
                Expanded(
                    child: Text(
                  "Segment",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
                Expanded(
                    child: Text(
                  "Word",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ],
            ),
            const SizedBox(height: 15),
            Column(
              children: _vocabSegmentsControllers
                  .map((List<TextEditingController> vocabSegmentController) =>
                      Column(children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: TextFormField(
                                  readOnly: false,
                                  controller: vocabSegmentController[0],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: TextFormField(
                                  readOnly: false,
                                  controller: vocabSegmentController[1],
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
              child: const Text("Add Segment"),
              onPressed:
                  // (_vocabSegmentsControllers.length > 0 &&
                  //         _vocabSegmentsControllers[
                  //                     _vocabSegmentsControllers.length - 1][0]
                  //                 .text
                  //                 .trim() ==
                  //             "" &&
                  //         _vocabSegmentsControllers[
                  //                     _vocabSegmentsControllers.length - 1][1]
                  //                 .text
                  //                 .trim() ==
                  //             "")
                  //     ? null
                  //     :
                  () {
                if (_vocabSegmentsControllers.length > 0 &&
                    _vocabSegmentsControllers[
                                _vocabSegmentsControllers.length - 1][0]
                            .text
                            .trim() ==
                        "" &&
                    _vocabSegmentsControllers[
                                _vocabSegmentsControllers.length - 1][1]
                            .text
                            .trim() ==
                        "") {
                  showSnackbarMessage(context,
                      success: false,
                      message: "Please fill in all segments and words first.");
                  return;
                }
                setState(() {
                  _vocabSegmentsControllers
                      .add([TextEditingController(), TextEditingController()]);
                });
              },
            ),
            ElevatedButton(
              child: const Text("Delete Segment"),
              onPressed: _vocabSegmentsControllers.isEmpty
                  ? null
                  : () {
                      // Delete segment
                      if (_vocabSegmentsControllers.length == 0) return;
                      setState(() {
                        _vocabSegmentsControllers.removeLast();
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
