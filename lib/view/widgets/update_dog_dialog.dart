import 'package:flutter/material.dart';
import 'package:sqlite_test/models/dog.dart';
import 'package:sqlite_test/provider/dogs_provider.dart';

class UpdateDogDialog extends StatefulWidget {
  final DogsProvider provider;
  final Dog dogModel;

  UpdateDogDialog(
    this.provider,
    this.dogModel,
  );

  @override
  _UpdateDogDialogState createState() => _UpdateDogDialogState();
}

class _UpdateDogDialogState extends State<UpdateDogDialog> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.dogModel.name;
    _ageController.text = widget.dogModel.age.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Dog'),
      content: Column(
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
        ],
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
                  final updatedDog = Dog(
                    id: widget.dogModel.id,
                    name: name,
                    age: age,
                  );

                  widget.provider.updateDog(updatedDog);
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
