import 'package:flutter/material.dart';
import 'form_screen.dart';
import 'note_detail.dart';
import 'login_screen.dart';
import 'profile.dart';

class DashboardPage extends StatelessWidget {
  final List<Note> notes = [
    Note(
      date: '2023-01-01',
      title: 'Catatan Pertama',
      content: 'Isi dari catatan pertama.',
    ),
    Note(
      date: '2023-01-02',
      title: 'Catatan Kedua',
      content: 'Isi dari catatan kedua.',
    ),
    // Add more notes if needed
  ];

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
                // Add logout logic here, such as clearing tokens or login status.

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
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return Card(
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(note.date),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NoteDetailPage(note: note)),
                );
              },
            ),
          );
        },
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
  final String date;
  final String title;
  final String content;

  Note({
    required this.date,
    required this.title,
    required this.content,
  });
}