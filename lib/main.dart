import 'package:flutter/material.dart';
import 'package:reading_book_counter/ui/book_grid_item.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My Favorite books',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookList()
    );
  }
}
