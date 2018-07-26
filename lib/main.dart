import 'package:flutter/material.dart';
import 'package:reading_book_counter/ui/book_grid_item.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: new BookListPage()
      home: GridListDemo()
    );
  }
}
