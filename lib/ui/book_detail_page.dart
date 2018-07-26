import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(title: new Text("book detail")),
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
    return new Image.asset('assets/01.jpg', height: 320.0, fit: BoxFit.cover);
  }

  Widget buildTitleSection() {
    return Container(
      padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(child: Text('絵本のタイトル', style: TextStyle(fontWeight: FontWeight.bold),)),
            Icon(Icons.favorite, color: Colors.pinkAccent,),
            Text('99'),
          ],
        )
    );
  }

  Widget buildDetailSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 32.0),
      child: Text('絵本のメモ。あらすじとか、お気に入りのフレーズ、こんなところがおもしろかった、おもしろくなかった、など。Twitterを参考に、140文字程度')
    );
  }
}