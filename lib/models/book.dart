class Book {

  final String id;
  final String title;
  final String assetName;

  String get tag => id;

  Book({this.id, this.title, this.assetName});
}