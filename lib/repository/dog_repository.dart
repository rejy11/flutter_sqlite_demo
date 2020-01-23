import 'package:sqlite_test/database/database.dart';
import 'package:sqlite_test/models/dog.dart';

class DogRepository {
  MyDatabase database;

  DogRepository(this.database);

  Future<List<Dog>> getAllDogs() async {
    return await database.dogs();
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
}