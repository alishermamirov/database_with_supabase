import 'package:database_with_supabase/models/note.dart';
import 'package:database_with_supabase/services/note_service.dart';
import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final service = NoteService();
  final noteController = TextEditingController();

  //add
  void addNote() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add new note"),
          content: TextField(
            controller: noteController,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                noteController.clear();

                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final note = Note(content: noteController.text);
                await service.createNote(note);
                noteController.clear();

                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  //update

  void updateNote(Note oldNote) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update note"),
          content: TextField(
            controller: noteController,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                noteController.clear();

                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final note = noteController.text;
                await service.updateNote(oldNote, note);
                noteController.clear();

                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  //delete
  void deleteNode(Note note) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete note"),
          actions: [
            ElevatedButton(
              onPressed: () {
                noteController.clear();

                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await service.deleteNote(note);
                noteController.clear();

                Navigator.pop(context);
              },
              child: const Text("Delete"),
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
        title: const Text("Notes"),
      ),
      body: StreamBuilder(
        stream: service.readNotes,
        builder: (context, snapshot) {
          print(snapshot.data);
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final notes = snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Card(
                child: ListTile(
                  title: Text(note.content!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          updateNote(note);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteNode(note);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNote();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
