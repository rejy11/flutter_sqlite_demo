import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../models/dog.dart';
import '../../provider/dogs_provider.dart';
import 'update_dog_dialog.dart';

class DogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DogsProvider>(context);
    final getAllDogs = provider.getAllDogs;

    return FutureBuilder<List<Dog>>(
      future: getAllDogs(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, i) {
            return Column(
              children: <Widget>[
                Slidable(
                  actionPane: SlidableStrechActionPane(),
                  actionExtentRatio: 0.25,
                  child: ListTile(
                    title: Text(snapshot.data[i].name),
                    subtitle: snapshot.data[i].toys.length != 1
                        ? Text('${snapshot.data[i].toys.length} toys')
                        : Text('${snapshot.data[i].toys.length} toy'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => UpdateDogDialog(
                          provider,
                          snapshot.data[i],
                        ),
                      );
                    },
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                      icon: Icons.delete,
                      color: Theme.of(context).errorColor,
                      onTap: () {
                        provider.deleteDog(snapshot.data[i].id);
                      },
                    )
                  ],
                ),
                Container(
                  color: Colors.black.withOpacity(0.05),
                  height: 1,
                )
              ],
            );
          },
        );
      },
    );
  }
}
