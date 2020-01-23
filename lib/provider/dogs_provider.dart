import 'package:flutter/foundation.dart';
import 'package:sqlite_test/models/dog.dart';
import 'package:sqlite_test/repository/dog_repository.dart';

class DogsProvider with ChangeNotifier {
  DogRepository repository;

  DogsProvider(this.repository);

  Future<List<Dog>> getAllDogs() async {
    final dogs = await repository.getAllDogs();
    dogs.sort((a,b) => a.name.compareTo(b.name));
    return dogs;
  }

  Future insertDog(String name, int age) async {
    final newDog = Dog(name: name, age: age);
    await repository.insertDog(newDog);
    notifyListeners();
  }

  Future deleteDog(int id) async {
    await repository.deleteDog(id);
    notifyListeners();
  }

  Future updateDog(Dog dog) async {
    await repository.updateDog(dog);
    notifyListeners();
  }
}
