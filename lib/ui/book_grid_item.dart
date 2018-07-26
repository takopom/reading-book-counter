import 'package:flutter/material.dart';
import 'package:reading_book_counter/models/book.dart';

const double _kMinFlingVelocity = 800.0;
typedef void BannerTapCallback(Book book);


class GridBookViewer extends StatefulWidget {
  const GridBookViewer({Key key, this.book}) : super(key: key);
  final Book book;

  @override
  _GridBookViewerState createState() => new _GridBookViewerState();
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

class _GridBookViewerState extends State<GridBookViewer> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<Offset> _flingAnimation;
  Offset _offset = Offset.zero;
  Offset _normalizedOffset;
  double _scale = 1.0;
  double _previousScale;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(vsync: this)..addListener(_handleFlingAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset _clampOffset(Offset offset) {
    final Size size = context.size;
    final Offset minOffset = new Offset(size.width, size.height) * (1.0 - _scale);
    return new Offset(offset.dx.clamp(minOffset.dx, 0.0), offset.dy.clamp(minOffset.dy, 0.0));
  }

  void _handleFlingAnimation() {
    setState(() {
      _offset = _flingAnimation.value;
    });
  }

  void _handleOnScaleStart(ScaleStartDetails details) {
    setState(() {
      _previousScale = _scale;
      _normalizedOffset = (details.focalPoint - _offset) / _scale;
      _controller.stop();
    });
  }

  void _handleOnScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = (_previousScale * details.scale).clamp(1.0, 4.0);
    });
  }

  void _handleOnScaleEnd(ScaleEndDetails details) {
    final double magnitude = details.velocity.pixelsPerSecond.distance;
    if (magnitude < _kMinFlingVelocity) return;

    final Offset direction = details.velocity.pixelsPerSecond / magnitude;
    final double distance = (Offset.zero & context.size).shortestSide;

    _flingAnimation = new Tween<Offset>(
      begin: _offset,
      end: _clampOffset(_offset + direction * distance)
    ).animate(_controller);

    _controller
      ..value = 0.0
      ..fling(velocity: magnitude / 1000.0);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onScaleStart: _handleOnScaleStart,
      onScaleUpdate: _handleOnScaleUpdate,
      onScaleEnd: _handleOnScaleEnd,
      child: new ClipRect(
        child: new Transform(
          transform: new Matrix4.identity()
              ..translate(_offset.dx, _offset.dy)
              ..scale(_scale),
          child: new Image.asset(
            widget.book.assetName,
            fit: BoxFit.cover,
          )
        )
      )
    );
  }
}

class GridBookItem extends StatelessWidget {
  GridBookItem({
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
          return new Scaffold(
            appBar: new AppBar(title: new Text(book.title)),
            body: new SizedBox.expand(
              child: new Hero(
                tag: book.tag,
                child: new GridBookViewer(book: book),
              )
            )
          );
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = new GestureDetector(
      onTap: (){ showBook(context); },
      child: new Hero(
        key: new Key(book.assetName),
        tag: book.id,
        child: new Image.asset(
          book.assetName,
          fit: BoxFit.cover,
        ),
      ),
    );

    final IconData icon = Icons.star;

    // one line tilestyle
    return new GridTile(
      footer: new GestureDetector(
        onTap: () { onBannerTap(book); },
        child: new GridTileBar(
          backgroundColor: Colors.black45,
          title: new _GridTitleText(book.title),
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

class GridListDemo extends StatefulWidget {
  const GridListDemo({Key key}) : super(key: key);

  @override
  GridListDemoState createState() => new GridListDemoState();
}

class GridListDemoState extends State<GridListDemo> {

  List<Book> books = <Book>[
    new Book(
      id: 'book01',
      title: 'book 01 title',
      assetName: 'assets/01.jpg',
    ),
    new Book(
      id: 'book02',
      title: 'book 02 title',
      assetName: 'assets/02.jpg',
    ),
    new Book(
      id: 'book03',
      title: 'book 03 title',
      assetName: 'assets/03.jpg',
    ),
    new Book(
      id: 'book04',
      title: 'book 04 title',
      assetName: 'assets/04.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Grid List'),
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
                  return new GridBookItem(
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
    );
  }
}