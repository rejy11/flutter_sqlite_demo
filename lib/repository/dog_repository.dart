import 'package:flutter/foundation.dart';
import 'package:sqlite_test/database/database.dart';
import 'package:sqlite_test/models/dog.dart';
import 'package:sqlite_test/models/toy.dart';

class DogRepository {
  MyDatabase database;

  DogRepository(this.database);

  Future<List<Dog>> getAllDogs() async {
    final dogs = await database.dogs();
    dogs.forEach((d) => debugPrint(d.toString()));
    return dogs;
  }

  Future<Dog> getDog(int id) async {
    final dogs = await database.dogs();
    return dogs.firstWhere((d) => d.id == id);
  }

  Future insertDog(Dog dog) async {
    return await database.insertDog(dog);
  }

  Future updateDog(Dog dog) async {
    return await database.updateDog(dog);
  }

  Future deleteDog(int id) async {
    return await database.deleteDog(id);
  }

  Future insertToy(Toy toy, Dog dog) async {
    return await database.insertToy(toy, dog);
  }
}