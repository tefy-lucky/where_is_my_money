import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:where_is_my_money/model/bro.dart';

class DatabaseHelper {
  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String AMOUNT = 'amount';
  static const String IS_PAID = 'isPaid';
  static const String TABLE = 'Bro';
  static const String DB_NAME = 'bros.db';

  Future<Database> get db async{
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $NAME TEXT, $AMOUNT DOUBLE, $IS_PAID TEXT)'
    );
  }
}