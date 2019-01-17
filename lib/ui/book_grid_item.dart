import 'package:flutter/material.dart';
import 'package:reading_book_counter/models/book.dart';
import 'package:reading_book_counter/ui/book_detail_page.dart';
import 'add_book_page.dart';

typedef void BannerTapCallback(Book book);

class _AddButton extends StatelessWidget {

  _pushBook(BuildContext context) {
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return AddBookPage();
      },
      fullscreenDialog: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () { _pushBook(context); },
      backgroundColor: Colors.pink,
      child: Icon(Icons.add),
    );
  }
}

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return new FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: new Text(text),
    );
  }
}

class _BookGridItem extends StatelessWidget {
  _BookGridItem({
    Key key,
    @required this.book,
    @required this.onBannerTap
  }) :  assert(book != null),
        assert(onBannerTap != null),
        super(key: key);

  final Book book;
  final BannerTapCallback onBannerTap;

  void showBook(BuildContext context) {
    Navigator.push(context, new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new BookDetailPage(book: book);
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = new GestureDetector(
      onTap: (){ showBook(context); },
      child: new Hero(
        key: new Key(book.asset),
        tag: book.id,
        child: new Image.asset(
          book.asset,
          fit: BoxFit.cover,
        ),
      ),
    );

    final IconData icon = Icons.favorite;

    // one line tilestyle
    return new GridTile(
      footer: new GestureDetector(
        onTap: () { onBannerTap(book); },
        child: new GridTileBar(
          backgroundColor: Colors.black45,
          title: new _GridTitleText('5'),
          leading: new Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
      child: image,
    );
  }
}

class BookList extends StatefulWidget {
  const BookList({Key key}) : super(key: key);

  @override
  BookListState createState() => new BookListState();
}

class BookListState extends State<BookList> {

  List<Book> books = <Book>[
    new Book(
      id: 1,
      title: 'book 01 title',
      asset: 'assets/01.jpg',
      note: '絵本のメモ。',
    ),
    new Book(
      id: 2,
      title: 'book 02 title',
      asset: 'assets/02.jpg',
      note: 'あらすじとか、お気に入りのフレーズ',
    ),
    new Book(
      id: 3,
      title: 'book 03 title',
      asset: 'assets/03.jpg',
      note: 'こんなところがおもしろかった',
    ),
    new Book(
      id: 4,
      title: 'book 04 title',
      asset: 'assets/04.jpg',
      note: 'おもしろくなかった、など。',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Book list'),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new SafeArea(
              top: false,
              bottom: false,
              child: new GridView.count(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                padding: const EdgeInsets.all(4.0),
                childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
                children: books.map((Book book) {
                  return new _BookGridItem(
                    book: book,
                    onBannerTap: (Book book) {
                      setState(() {
                        // book count
                      });
                    });
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _AddButton(),
    );
  }
}