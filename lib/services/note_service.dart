import 'package:database_with_supabase/models/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteService {
  final database = Supabase.instance.client.from("note");

  //create
  Future createNote(Note note) async {
    await database.insert(note.toMap());
  }

  //read
  final readNotes =
      Supabase.instance.client.from("note").stream(primaryKey: ["id"]).map(
    (data) => data
        .map(
          (noteData) => Note.fromMap(noteData),
        )
        .toList(),
  );

  //update

  Future updateNote(Note oldNote, String content) async {
    await database.update({"content": content}).eq("id", oldNote.id!);
  }

  //delete
  Future deleteNote(Note note) async {
    await database.delete().eq("id", note.id!);
  }
}
