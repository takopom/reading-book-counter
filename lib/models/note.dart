class Note {
  static final String db_id = "id";
  static final String db_book_id = "book_id";
  static final String db_date = "date";

  int id;
  final int book_id;
  String date;

  int get tag => id;

  Note({this.id, this.book_id, this.date});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      db_id: id,
      db_book_id: book_id,
      db_date: date,
    };

    return map;
  }

  Note.fromMap(Map<String, dynamic> map): this(
    id: map[db_id],
    book_id: map[db_book_id],
    date: map[db_date],
  );
}