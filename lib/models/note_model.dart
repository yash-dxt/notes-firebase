class Note {
  String id;
  final String title;
  final String content;

  Note({this.title, this.content, this.id});

  Map<String, dynamic> toMap() => {
        'id' : id,
        'title': title,
        'content': content,
      };

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}
