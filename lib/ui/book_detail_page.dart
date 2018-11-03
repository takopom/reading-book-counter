import 'package:flutter/material.dart';
import 'package:reading_book_counter/models/book.dart';

class BookDetailPage extends StatelessWidget {

  final Book book;

  BookDetailPage({Key key, @required this.book}) : assert(book != null), super(key: key);

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(title: new Text("Book detail")),
      body: new ListView(
        children: <Widget>[
          buildImageSection(),
          buildTitleSection(),
          buildDetailSection(),
        ],
      )
    );
  }

  Widget buildImageSection() {
    return new Image.asset(book.assetName, height: 320.0, fit: BoxFit.cover);
  }

  Widget buildTitleSection() {
    return Container(
      padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(child: Text(book.title, style: TextStyle(fontWeight: FontWeight.bold),)),
            Icon(Icons.favorite, color: Colors.pinkAccent,),
            Text(book.count.toString()),
          ],
        )
    );
  }

  Widget buildDetailSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 32.0),
      child: Text(book.comment)
    );
  }
}