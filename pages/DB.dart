import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DB {
  static Database db;
  static String _path;
  static Future<bool> initialize() async {
    if (db == null) {
      db = await _configure();
      var rows = await getData();
      if(rows.isEmpty)
        {
          loadSampleData();
        }
    }
    return db.isOpen;
  }

  static Future<Database> _configure() async {
    _path = await getDatabasesPath();
    _path = _path + '/' + 'mydb.db';
    return await openDatabase(_path, onCreate: onCreateDatabase, version: 1);
  }

  static void onCreateDatabase(Database db, int version) {
    db.execute('''create table items (item text)''');
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    return await db.rawQuery('select * from items');
  }

  static Future<bool> insert(Map<String, dynamic> data) async {
    return await db.insert('items', data) > 0;
  }

  static void loadSampleData() async {
    Map<String, String> map = Map();
    for(int i=0;i<10;i++)
      {
        map['ITEM'] = "item :$i";
        insert(map);
      }
  }
}