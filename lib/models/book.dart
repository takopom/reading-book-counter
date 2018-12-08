class Book {
  static final String db_id = "id";
  static final String db_isbn = "isbn";
  static final String db_title = "title";
  static final String db_asset = "asset";
  static final String db_note = "note";
  static final String db_url = "url";

  int id;
  final String isbn;
  final String title;
  final String asset;
  final String note;
  final String url;

  String get tag => isbn;

  Book({this.id, this.isbn, this.title, this.asset, this.note, this.url});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      db_id : id,
      db_isbn : isbn,
      db_title: title,
      db_asset: asset,
      db_note : note,
      db_url : url,
    };

    return map;
  }

  Book.fromMap(Map<String, dynamic> map): this(
    id: map[db_id],
    isbn: map[db_isbn],
    title: map[db_title],
    asset: map[db_asset],
    note: map[db_note],
    url: map[db_url],
  );
}