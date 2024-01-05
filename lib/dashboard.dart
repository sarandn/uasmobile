import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uasnote/api_manager.dart';
import 'form_screen.dart';
import 'note_detail.dart';
import 'login_screen.dart';
import 'profile.dart';
import 'update_form.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    final apiManager = Provider.of<ApiManager>(context, listen: false);

    try {
      List<Note> fetchedNotes = await apiManager.getNotes();
      setState(() {
        notes = fetchedNotes;
      });
    } catch (e) {
      // Handle error (e.g., show an error message)
      print('Error fetching notes: $e');
    }
  }

  Future<void> _deleteNote(int id) async {
    final apiManager = Provider.of<ApiManager>(context, listen: false);

    try {
      await apiManager.deleteNoteDetail(id);
      // Reload notes after successful deletion
      await _fetchNotes();
    } catch (e) {
      // Handle error (e.g., show an error message)
      print('Error deleting note: $e');
    }
  }

  Future<void> _showDeleteConfirmationDialog(int noteId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this note?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                await _deleteNote(noteId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes Dashboard'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              } else if (value == 'logout') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'profile',
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return Card(
              color: Colors.brown,
              child: ListTile(
                title: Text(
                  note.judul,
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        _showDeleteConfirmationDialog(note.isi as int);
                        // Add logic for deleting the note
                        // You can use 'note' to identify and delete the corresponding note
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NoteUpdateFormPage(note: note),
                          ),
                        ).then((_) {
                          // Reload notes after returning from update screen
                          _fetchNotes();
                        });
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteDetailPage(note: note),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteFormPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Note {
  final String judul;
  final String created_at;
  final String isi;

  Note({
    required this.created_at,
    required this.judul,
    required this.isi,
  });
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      created_at: json['created_at'],
      judul: json['judul'],
      isi: json['isi'],
    );
  }
}
