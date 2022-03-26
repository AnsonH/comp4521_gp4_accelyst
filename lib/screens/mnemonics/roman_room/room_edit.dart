import 'package:comp4521_gp4_accelyst/widgets/photo/add_photo_button.dart';
import 'package:flutter/material.dart';

class RoomEdit extends StatefulWidget {
  const RoomEdit({Key? key}) : super(key: key);

  @override
  State<RoomEdit> createState() => _RoomEditState();
}

class _RoomEditState extends State<RoomEdit> {
  final _formKey = GlobalKey<FormState>();

  /* TODO:
   * 1. Create a model class to represent form data
   * 2. Validate the form on save
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Roman Room"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            // Using slivers allow us to scroll the list and grid views together
            // See https://api.flutter.dev/flutter/widgets/SliverList-class.html
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Name"),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Subject"),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Description"),
                      keyboardType: TextInputType.multiline,
                      maxLines: null, // Take as much lines as the input value
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Your Roman Room",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              // TODO: Switch to PhotoGrid if there are >=1 photos
              SliverList(
                delegate: SliverChildListDelegate([
                  const AddPhotoButton(),
                ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 30),
                  Text(
                    "Room Objects",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
