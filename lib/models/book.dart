class Book {

  final String id;
  final String title;
  final String assetName;
  final int count;
  final String comment;

  String get tag => id;

  Book({this.id, this.title, this.assetName, this.count, this.comment});
}