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
  TextEditingController _toyController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.dogModel.name;
    _ageController.text = widget.dogModel.age.toString();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _toyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Dog'),
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
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextField(
                controller: _toyController,
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    setState(() {});
                  }
                },
                decoration: InputDecoration(
                  helperText: 'Toy Type',
                  hintText: 'e.g tennis ball',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    color: Theme.of(context).accentColor,
                    onPressed: _toyController.text.isNotEmpty
                        ? () {
                            widget.provider.addToyToDog(
                              widget.dogModel.id,
                              _toyController.text,
                            );
                            //fixes issue with clear text https://github.com/flutter/flutter/issues/35848
                            WidgetsBinding.instance.addPostFrameCallback( (_) => _toyController.clear());
                          }
                        : null,
                  ),
                ),
              ),
            )
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
              widget.provider.updateDog(widget.dogModel.id,
                  _nameController.text, _ageController.text);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
