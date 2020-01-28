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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'toys': toys,
    };
  }
}
