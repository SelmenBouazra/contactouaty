import 'package:contactouaty/data/contact_option.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data/contact.dart';

class ContactDataBase {
  static const String _databaseName = 'my_database.db';
  static const String _contactTableName = 'contact';
  static const String _optionTableName = 'contact';
  static const int _databaseVersion = 1;

  static Database? _database;

  ContactDataBase._();

  static final ContactDataBase instance = ContactDataBase._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_contactTableName (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        job TEXT
        )
        ''');

    await db.execute('''
          CREATE TABLE $_optionTableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            contact_id INTEGER,
            url TEXT, 
            image TEXT,
            FOREIGN KEY (contact_id) REFERENCES $_contactTableName(id) ON DELETE CASCADE
          )
        ''');
  }

  Future<int> insertContact(Contact contact) async {
    final Database db = await instance.database;
    return await db.insert(_contactTableName, contact.toMap2(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Contact>> getAllContacts() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_contactTableName);
    return List.generate(maps.length, (i) => Contact.fromJson2(maps[i]));
  }

  Future<int> insertOption(ContactOption contactOption) async {
    final Database db = await instance.database;
    return await db.insert(_optionTableName, contactOption.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ContactOption>> getAllOption() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_optionTableName);
    return List.generate(maps.length, (i) => ContactOption.fromJson(maps[i]));
  }
}
