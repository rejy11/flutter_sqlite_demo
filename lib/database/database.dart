import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_test/models/dog.dart';
import 'package:sqlite_test/models/toy.dart';

class MyDatabase {
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    final directory = await getDatabasesPath();
    String path = join(directory, "dog.db");

    deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        debugPrint('Database OnUpgrade');
        // await db.execute(
        //   "ALTER TABLE dogs RENAME TO dog",
        // );
        // await db.execute(
        //   "CREATE TABLE toy(id INTEGER PRIMARY KEY, toytype TEXT, dogid INTEGER, FOREIGN KEY(dogid) REFERENCES dog(id))",
        // );
      },
      onCreate: (Database db, int version) async {
        debugPrint('Database OnCreate');
        await db.execute(
          "CREATE TABLE dog(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)",
        );
        await db.execute(
          "CREATE TABLE toy(id INTEGER PRIMARY KEY AUTOINCREMENT, toytype TEXT, dogid INTEGER, FOREIGN KEY(dogid) REFERENCES dog(id) ON DELETE CASCADE)",
        );
      },
    );
  }

  Future<List<Dog>> dogs() async {
    final db = await database;
    //get dogs and join onto toys table
    final List<Map<String, dynamic>> dogMaps = await db.rawQuery(
      'SELECT dog.id, dog.name, dog.age, toy.toytype FROM dog LEFT JOIN toy ON dog.id = toy.dogid',
    );
    //get all toys
    final List<Map<String, dynamic>> toyMaps =
        await db.rawQuery('SELECT * FROM toy');
    //generate list of toys to use in our dog list
    final toyList = List.generate(toyMaps.length, (i) {
      return Toy(
          id: toyMaps[i]['id'],
          toyType: toyMaps[i]['toytype'],
          dogId: toyMaps[i]['dogid']);
    });
    //return list of dogs with their associated toys
    return List.generate(dogMaps.length, (i) {
      return Dog(
        id: dogMaps[i]['id'],
        name: dogMaps[i]['name'],
        age: dogMaps[i]['age'],
        toys: toyList.where((toy) => toy.dogId == dogMaps[i]['id']).toList(),
      );
    });
  }

  Future<void> insertDog(Dog dog) async {
    final db = await database;
    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'dog',
      dog.toMap(),
    );
  }

  Future<void> updateDog(Dog dog) async {
    final db = await database;
    await db.update(
      'dog',
      dog.toMap(),
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id], 
    );
  }

  Future<void> insertToy(Toy toy, Dog dog) async {
    debugPrint(toy.toString());

    final db = await database;

    for (var toy in dog.toys) {
      await db.insert(
        'toy',
        {
          'id': toy.id,
          'toytype': toy.toyType,
          'dogid': toy.dogId,
        },
      );
    }
  }

  Future<void> deleteDog(int id) async {
    final db = await database;
    await db.delete(
      'dog',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
