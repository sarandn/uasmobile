import 'package:flutter/material.dart';
import 'api_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// import 'draw:io';

class NoteFormPage extends StatefulWidget {
  @override
  _NoteFormPageState createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Content',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _fileController,
                    decoration: InputDecoration(
                      labelText: 'Choose File',
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Implement logic to choose a file
                    chooseFile();
                  },
                  child: Text('Browse'),
                ),
              ],
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Implement logic to save the note
                saveNote();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void saveNote() {
    // Retrieve the entered values
    final String title = _titleController.text;
    final String content = _contentController.text;
    final String selectedFile = _fileController.text;

    // Perform the logic to save the note (you can save to a database, file, etc.)
    // For now, let's just print the values
    print('Title: $title');
    print('Content: $content');
    print('Selected File: $selectedFile');

    // Optionally, you can navigate back to the previous screen or perform other actions
    Navigator.pop(context);
  }

  void chooseFile() {
    // Implement logic to choose a file (you can use plugins like file_picker)
    // For now, let's just print a message
    print('Choosing a file...');
  }
}
