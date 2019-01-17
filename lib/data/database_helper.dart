import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:reading_book_counter/models/book.dart';
import 'package:reading_book_counter/models/note.dart';

class BookDatabaseHelper {

  final int _DatabaseVersion = 1;
  final String _DatabaseName = 'book.db';
  final String _BookTableName = 'books';
  final String _NotesTableName = 'notes';

  static Database _db;

  static final BookDatabaseHelper _instance = new BookDatabaseHelper._internal();

  factory BookDatabaseHelper() => _instance;

  BookDatabaseHelper._internal();

  Future<Database> get db async {
    if (_db == null) {
      await _open();
    }
    return _db;
  }

  Future<String> _getDBPath() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, _DatabaseName);
    return path;
  }

  void _open() async {
    var dbPath = await _getDBPath();
    print(dbPath);
    await deleteDatabase(dbPath);
    _db = await openDatabase(dbPath, version: _DatabaseVersion, onCreate: _onCreate);
  }

  Future close() async {
    var client = await db;
    return client.close();
  }
  
  Future<Book> getBook(int id) async {
    var client = await db;
    List<Map> books = await client.query(
        _BookTableName,
        columns: [Book.db_id, Book.db_title, Book.db_asset, Book.db_note],
        where: "${Book.db_id} = ?",
        whereArgs: [id]
    );

    if (books.length > 0) {
      return Book.fromMap(books.first);
    }

    return null;
  }

  Future<List> getBooks() async {
    var client = await db;
    List<Map> result = await client.rawQuery("SELECT * FROM $_BookTableName");

    if (result == null) {
      return null;
    }

    var books = new List<Book>();
    result.forEach((item) => books.add(Book.fromMap(item)));

    return books;
  }

  Future<Book> insertBook(Book book) async {
    var client = await db;
    book.id = await client.insert(_BookTableName, book.toMap());
    return book;
  }

  Future<int> deleteBook(int id) async {
    var client = await db;
    return await client.delete(_BookTableName, where: '${Book.db_id} = ?', whereArgs: [id]);
  }

  Future<int> updateBook(Book book) async {
    var client = await db;
    return await client.update(_BookTableName, book.toMap(), where: '${Book.db_id} = ?', whereArgs: [book.id]);
  }

  Future<Note> insertNote(Note note) async {
    var client = await db;
    note.date = new DateTime.now().toUtc().toString();
    note.id = await client.insert(_NotesTableName, note.toMap());
    return note;
  }
  
  Future<int> deleteNote(int id) async {
    var client = await db;
    return await client.delete(_NotesTableName, where: '${Note.db_id} = ?', whereArgs: [id]);
  }

  Future<int> updateNote(Note note) async {
    var client = await db;
    return await client.update(_NotesTableName, note.toMap(), where: '${Note.db_id} = ?', whereArgs: [note.id]);
  }

  Future<List> selectNotes() async {
    var client = await db;
    List<Map> result = await client.rawQuery("SELECT * FROM $_NotesTableName");

    if (result == null) {
      return null;
    }

    var notes = new List<Note>();
    result.forEach((item) => notes.add(Note.fromMap(item)));

    return notes;
  }

  Future<List> selectBookNotes(int bookID) async {
    var client = await db;
    List<Map> result = await client.query(_NotesTableName, where: '${Note.db_book_id} = ?', whereArgs: [bookID]);

    if (result == null) {
      return null;
    }

    var notes = new List<Note>();
    result.forEach((item) => notes.add(Note.fromMap(item)));

    return notes;
  }

  // Create Table
  void _onCreate(Database db, int newVersion) async {
    var client = await db;
    await client.execute(_createBookTable());
    await client.execute(_createNotesTable());
  }

  String _createBookTable() {
    return "CREATE TABLE $_BookTableName ("
        "id INTEGER PRIMARY_KEY, "
        "${Book.db_title} TEXT,"
        "${Book.db_note} TEXT,"
        "${Book.db_asset} TEXT"
        ")";
  }

  String _createNotesTable() {
    return "CREATE TABLE $_NotesTableName ("
        "id INTEGER PRIMARY_KEY, "
        "${Note.db_book_id} INTEGER,"
        "${Note.db_date} TEXT"
        ")";
  }
}