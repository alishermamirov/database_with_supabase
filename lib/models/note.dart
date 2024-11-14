class Note {
  int? id;
  String? content;
  Note({required this.id, required this.content});

  factory Note.fromMap(Map<String, dynamic> data) {
    return Note(
      id: data["id"] as int,
      content: data["content"] as String,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "content": content,
    };
  }
}
