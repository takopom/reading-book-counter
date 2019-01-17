class Book {
  static final String db_id = "id";
  static final String db_title = "title";
  static final String db_asset = "asset";
  static final String db_note = "note";

  int id;
  final String title;
  final String asset;
  final String note;

  int get tag => id;

  Book({this.id, this.title, this.asset, this.note});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      db_id : id,
      db_title: title,
      db_asset: asset,
      db_note : note,
    };

    return map;
  }

  Book.fromMap(Map<String, dynamic> map): this(
    id: map[db_id],
    title: map[db_title],
    asset: map[db_asset],
    note: map[db_note],
  );
}