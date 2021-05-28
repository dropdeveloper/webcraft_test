import 'package:app/model/empl_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBHelper {
  late Database _db;

  late String dbName = "debug_08.db";
  //table ans colums names
  late String tblEmp = "tbl_empl";

  //colums key
  late String id = "key";
  //Employee colums
  late String rowId = "id";
  late String rowFname = "name";
  late String rowUname = "username";
  late String rowEmail = "email";
  late String rowProfileImg = "profile_image";
  late String rowPhone = "phone";
  late String rowWebSite = "website";
  //address colums
  late String rowStreet = "street";
  late String rowSuite = "suite";
  late String rowCity = "city";
  late String rowZipcode = "zipcode";

  //company colums
  late String rowCName = "company";
  late String rowCatchPhrase = "catchPhrase";
  late String rowBs = "bs";

  Future<Database> get db async {
    _db = await initDB();
    return _db;
  }

  initDB() async {
    io.Directory documentDir = await getApplicationDocumentsDirectory();
    String path = join(documentDir.path, dbName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    //create tbl_employy
    await db.execute(
        "CREATE TABLE $tblEmp ($id INTEGER PRIMARY KEY AUTOINCREMENT, $rowId INTEGER, $rowFname TEXT, $rowUname TEXT, $rowEmail TEXT, $rowProfileImg TEXT, $rowPhone TEXT, $rowWebSite TEXT, $rowCName TEXT, $rowCatchPhrase TEXT, $rowBs TEXT, $rowStreet TEXT, $rowSuite TEXT, $rowCity TEXT, $rowZipcode TEXT)");
  }

  Future<int> addEmploy(Employee user) async {
    var dbClient = await db;
    int id = await dbClient.insert(tblEmp, user.toMap());
    return id;
  }

  Future<List<Employee>> getEmployy() async {
    var dbClient = await db;
    List<Map<String, dynamic>> map = await dbClient.query(tblEmp);
    List<Employee> data = [];
    for (int x = 0; x < map.length; x++) {
      data.add(Employee.fromMap(map[x]));
    }
    return data;
  }

  Future<List<Employee>> getEmploySearch(String key) async {
    var dbClient = await db;
    List<Map<String, dynamic>> map = await dbClient
        .rawQuery("SELECT * FROM $tblEmp WHERE $rowFname LIKE '%$key%'");
    List<Employee> data = [];
    for (int x = 0; x < map.length; x++) {
      data.add(Employee.fromMap(map[x]));
    }
    return data;
  }

  Future<Employee> getEmployyById(int id) async {
    var dbClient = await db;
    List<Map<String, dynamic>> map =
        await dbClient.rawQuery("SELECT * FROM $tblEmp WHERE $rowId = '$id'");
    return Employee.fromMap(map[0]);
  }

  Future<int> deleteEmployy() async {
    var dbClient = await db;
    return await dbClient.delete(tblEmp);
  }
}
