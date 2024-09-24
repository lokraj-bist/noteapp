import 'package:flutter/material.dart';
import 'package:noteaapp/models/notes.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: controller1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                labelText: "Enter title",
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: controller2,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                labelText: "Enter description",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (controller1.text.isNotEmpty) {
                  notes newNote = notes(
                    title: controller1.text,
                    description: controller2.text,
                  );
                  Navigator.pop(context, newNote); 
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
