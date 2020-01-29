import 'package:flutter/material.dart';
import 'package:sqlite_test/provider/dogs_provider.dart';

class NewDogDialog extends StatefulWidget {
  final DogsProvider provider;

  NewDogDialog(this.provider);

  @override
  _NewDogDialogState createState() => _NewDogDialogState();
}

class _NewDogDialogState extends State<NewDogDialog> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Dog'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(helperText: 'Name'),
              controller: _nameController,
            ),
            TextField(
              decoration: InputDecoration(helperText: 'Age'),
              controller: _ageController,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 15),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       helperText: 'Toy Type',
            //       hintText: 'e.g tennis ball',
            //       suffixIcon: IconButton(
            //         icon: Icon(Icons.add),
            //         onPressed: () {
            //           //add toy
            //         },
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCEL'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text('SAVE'),
          onPressed: () {
            if (_nameController.text.isNotEmpty &&
                _ageController.text.isNotEmpty) {
              final name = _nameController.text;
              final age = int.tryParse(_ageController.text);
              if (age != null) {
                if (age >= 0) {
                  widget.provider.insertDog(name, age);
                  Navigator.pop(context);
                }
              }
            }
          },
        ),
      ],
    );
  }
}
