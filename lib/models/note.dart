class Note {
  static final String db_id = "id";
  static final String db_book_id = "book_id";
  static final String db_date = "date";
  static final String db_feeling = "feeling";

  int id;
  final int book_id;
  String date;
  final String feeling;

  int get tag => id;

  Note({this.id, this.book_id, this.date, this.feeling});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      db_id: id,
      db_book_id: book_id,
      db_date: date,
      db_feeling: feeling,
    };

    return map;
  }

  Note.fromMap(Map<String, dynamic> map): this(
    id: map[db_id],
    book_id: map[db_book_id],
    date: map[db_date],
    feeling: map[db_feeling],
  );
}