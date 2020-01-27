import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'container/injection_container.dart';
import 'provider/dogs_provider.dart';
import 'view/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sqlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.lightBlue[200]
      ),
      home: ChangeNotifierProvider(
        child: HomeScreen(),
        create: (ctx) => DogsProvider(serviceLocater()),
      ),
    );
  }
}
