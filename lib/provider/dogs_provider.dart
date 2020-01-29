import 'package:flutter/foundation.dart';
import 'package:sqlite_test/models/dog.dart';
import 'package:sqlite_test/models/toy.dart';
import 'package:sqlite_test/repository/dog_repository.dart';

class DogsProvider with ChangeNotifier {
  DogRepository repository;

  DogsProvider(this.repository);

  Future<List<Dog>> getAllDogs() async {
    final dogs = await repository.getAllDogs();
    dogs.sort((a, b) => a.name.compareTo(b.name));
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

  Future updateDog(int id, String name, String ageText) async {
    final age = int.tryParse(ageText);
    if (age != null) {
      if (age >= 0) {
        final updatedDog = Dog(
          id: id,
          name: name,
          age: age,
        );
        await repository.updateDog(updatedDog);
        notifyListeners();
      }
    }
  }

  Future addToyToDog(int dogId, String toyType) async {
    final toy = Toy(
      toyType: toyType,
      dogId: dogId,
    );
    final dog = await repository.getDog(dogId);
    if (dog != null) {
      dog.toys.add(toy);
    }
    await repository.insertToy(toy, dog);
    notifyListeners();
  }
}
