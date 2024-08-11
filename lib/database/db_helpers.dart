import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initalDb();
      return _db!;
    } else {
      return _db!;
    }
  }

  initalDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'course.db');
    Database db = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return db;
  }

  _onUpgrade(Database db, int version, int newVersion) {
    print('onUpgrade==========================');
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE "course" (
  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "content" TEXT NOT NULL,
  "courseName" TEXT NOT NULL,
  "hours" INTEGER NOT NULL
);

''');
    print('Create Database And Table ==============');
  }

  readData(String sql) async {
    Database mydb = await db;
    List<Map> response = await mydb.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database mydb = await db;
    int response = await mydb.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database mydb = await db;
    int response = await mydb.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database mydb = await db;
    int response = await mydb.rawDelete(sql);
    return response;
  }
}
