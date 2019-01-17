import 'package:flutter/material.dart';

class AddBookPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Add new book")
      ),
      body: AddBookForm(),
    );
  }
}

class AddBookForm extends StatefulWidget {
  @override
  AddBookFormState createState() => AddBookFormState();
}

class AddBookFormState extends State<AddBookForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _bookIconEdit(),
          _titleTextForm(),
          _commentTextForm(),
          _saveButton(context),
        ],
      ),
    );
  }

  Widget _bookIconEdit() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        _bookIconView(),
        _pictureEditButton(),
      ],
    );

  }

  Widget _bookIconView() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: ExactAssetImage('assets/01.jpg'),
        ),
      ),
    );
  }

  Widget _pictureEditButton() {
    return IconButton(
      icon: Icon(Icons.photo_camera),
      iconSize: 48,
      tooltip: '絵本の画像を指定できます',
      onPressed: () {
        // 写真を撮るまたは画像を選択できる
      },
    );
  }

  Widget _titleTextForm() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: '絵本のタイトル',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'タイトルを入力してください';
        }
      },
    );
  }

  Widget _commentTextForm() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: '絵本の感想',
      ),
    );
  }


  Widget _saveButton(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('保存しています')));
        }
      },
      child: Text('保存する'),
    );
  }
}
