import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/dogs_provider.dart';
import '../widgets/dog_list.dart';
import '../widgets/new_dog_dialog.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _scaffoldkey = GlobalKey<ScaffoldState>();
    final provider = Provider.of<DogsProvider>(context, listen: false);

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Dog Database'),
      ),
      body: DogList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: _scaffoldkey.currentContext,
            builder: (context) => NewDogDialog(
              provider,
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
