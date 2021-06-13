import 'package:FlutterApp/helper/constants.dart';
import 'package:FlutterApp/models/UserModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static Database _database;

  Future<Database> get database async {
    // if the db isn't null return it, if  equal null then start new db
    // using singleton, return the same instance each time, will not create new db when accessing the class
    if (_database != null) return _database;

    _database = await initDb();
    return _database;
  }

  initDb() async {
// get the path then name it then open the database with new version
    String path = join(await getDatabasesPath(), "UserData.db");
    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // in execute => the table query
      // table name and its columns
      await db.execute(''' CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY AUTOINCREMENT
        $columnName TEXT NOT NULL,
        $columnPhone TEXT NOT NULL,
        $columnPhone TEXT NOT NULL)
      ''');
    });
  }

  // CRUD methods
  Future<void> insertUser(UserModel user) async {
    var dbClient = await database;
    // insert new user with keys and values
    //conflictAlgorithm handling conflicts
    await dbClient.insert(
      tableName,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  updateUser(UserModel user) async {
    var dbClient = await database;
    await dbClient.update(
      tableName,
      user.toJson(),
      where: '$columnId = ?',
      whereArgs: [user.id],
    );
  }

  Future<UserModel> getUser(int id) async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return UserModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query(
      tableName,
    );
    return maps.isNotEmpty
        ? maps.map((user) => UserModel.fromJson(user)).toList()
        : [];
  }

  Future<void> deleteUser(int id) async {
    var dbClient = await database;
    return await dbClient.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
