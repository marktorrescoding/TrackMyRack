import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    path = join(path, 'your_database_name.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE your_table_name (id INTEGER PRIMARY KEY, category TEXT, item TEXT, name TEXT, details TEXT, manufacturedDate TEXT, strength TEXT)');

        // Create other tables if needed
      },
    );
  }

  Future<int> insertGear(Gear gear) async {
    final db = await database;
    return await db.insert('your_table_name', gear.toMap());
  }
}

class Gear {
  String category;
  String item;
  String name;
  String details;
  String manufacturedDate;
  String strength;

  Gear(
      this.category,
      this.item,
      this.name,
      this.details,
      this.manufacturedDate,
      this.strength,
      );

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'item': item,
      'name': name,
      'details': details,
      'manufacturedDate': manufacturedDate,
      'strength': strength,
    };
  }
}
