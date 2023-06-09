import 'package:flutter/material.dart';
import 'package:testapp/models/customuser.dart';
import 'package:testapp/services/database.dart';
import 'package:testapp/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:testapp/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Update your brew settings',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: userData!.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) {
                    setState(() {
                      _currentName = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                // dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _currentSugars = value;
                    });
                  },
                ),
                // slider
                Slider(
                  activeColor: Colors.brown[_currentStrength ?? 100],
                  inactiveColor: Colors.brown[_currentStrength ?? 100],
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _currentStrength = value.round();
                    });
                  },
                  min: 100,
                  max: 900,
                  divisions: 8,
                ),
                RaisedButton(
                  onPressed: () async {
                    // print(_currentName);
                    // print(_currentStrength);
                    // print(_currentSugars);
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength,
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  color: Colors.pink,
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
