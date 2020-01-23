import 'package:get_it/get_it.dart';
import 'package:sqlite_test/database/database.dart';
import 'package:sqlite_test/repository/dog_repository.dart';

final serviceLocater = GetIt.instance;

Future<void> init() async {
  serviceLocater.registerSingleton<MyDatabase>(MyDatabase());
  serviceLocater.registerSingleton<DogRepository>(DogRepository(serviceLocater()));
}