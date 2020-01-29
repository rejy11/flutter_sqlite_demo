import 'package:sqlite_test/models/toy.dart';

class Dog {
  final int id;
  final String name;
  final int age;
  final List<Toy> toys;

  Dog({
    this.id,
    this.name,
    this.age,
    this.toys,
  });

  //this logic should be moved to the database level as it is only needed for that
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'DOG => id: $id, name: $name, age: $age, toys: $toys';
  }
}
