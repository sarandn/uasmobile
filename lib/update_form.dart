import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uasnote/dashboard.dart';
import 'package:uasnote/api_manager.dart';

class NoteUpdateFormPage extends StatefulWidget {
  final Note note;


  NoteUpdateFormPage({required this.note});

  @override
  _NoteUpdateFormPageState createState() => _NoteUpdateFormPageState();
}

class _NoteUpdateFormPageState extends State<NoteUpdateFormPage> {
  late TextEditingController _judulController;
  late TextEditingController _isiController;

  @override
  void initState() {
    super.initState();
    _judulController = TextEditingController(text: widget.note.judul);
    _isiController = TextEditingController(text: widget.note.isi);
  }

  @override
  void dispose() {
    _judulController.dispose();
    _isiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _judulController,
              decoration: InputDecoration(labelText: 'judul'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _isiController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'isi'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final apiManager =
                        Provider.of<ApiManager>(context, listen: false);
                  await apiManager.updateNoteDetail(widget.note.isi, _judulController.text, _isiController.text);
                  // Update note locally or reload notes from API, depending on your architecture
                  Navigator.pop(context); // Kembali ke halaman sebelumnya setelah berhasil diupdate
                } catch (e) {
                  // Handle error (show an error message, etc.)
                  print('Error updating note: $e');
                }
              },
              child: Text('Update Note'),
            ),
          ],
        ),
      ),
    );
  }
}
