import 'package:flutter/material.dart';

class VocabHome extends StatefulWidget {
  const VocabHome({Key? key}) : super(key: key);

  @override
  State<VocabHome> createState() => _VocabHomeState();
}

class _VocabHomeState extends State<VocabHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vocabulary"),
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
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
