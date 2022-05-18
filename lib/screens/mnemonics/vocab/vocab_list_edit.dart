import 'package:flutter/material.dart';

class VocabListEdit extends StatefulWidget {
  final String id;
  const VocabListEdit({Key? key, required this.id}) : super(key: key);

  @override
  State<VocabListEdit> createState() => _VocabListEditState();
}

class _VocabListEditState extends State<VocabListEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vocabulary"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Name"),
              initialValue: "My Room",
              readOnly: true,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(labelText: "Subject"),
              initialValue: "COMP4521",
              readOnly: true,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(labelText: "Description"),
              keyboardType: TextInputType.multiline,
              maxLines: null, // Take as much lines as the input value
              initialValue: "Sample Text\nMiddle Text\nBottom Text",
              readOnly: true,
            ),
            const SizedBox(height: 20),
            Text(
              "Your Roman Room",
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 10),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      ),
    );
  }
}
