import 'package:coffeewala_app/models/user.dart';
import 'package:coffeewala_app/screens/services/database.dart';
import 'package:coffeewala_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<String> coffees = ['Mocha', 'Black Coffee', 'Espresso', 'Cafe Latte', 'Cappuccino', 'Breve', 'Cortado', 'Double Espresso', 'Red Eye', 'Black Eye', 'Americano', 'Long Black', 'Macchiato', 'Long Macchiato', 'Iced Coffee', 'Cafe au Lait', 'Affogato', 'Vienna'];
  final List<String> snacks = ['Biscuit', 'Cookie', 'Not needed'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;
  String _currentCoffees;
  String _currentSnacks;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
      coffees.sort();
      print(coffees);
      //print(snacks);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "Update your Coffee Preferences",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userData.name,
                      decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(color: Colors.black54)),
                      validator: (val) => val.isEmpty ? 'Enter an Name' : null,
                      onChanged: (val) {
                        setState(() {
                          _currentName = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    //DropDown
                    DropdownButtonFormField(
                      value: _currentSugars ?? userData.sugars,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _currentSugars = val;
                        });
                      },
                    ),

                    SizedBox(
                      height: 20.0,
                    ),

                    DropdownButtonFormField(
                      value: null ?? userData.coffees, 
                      items: coffees.map((coffee) {
                        return DropdownMenuItem(
                          value: coffee,
                          child: Text('$coffee'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _currentCoffees = val;
                        });
                      },
                      ),

                    SizedBox(
                      height: 20.0,
                    ),

                    DropdownButtonFormField(
                      value:null ?? userData.snacks, 
                      items: snacks.map((snack) {
                        return DropdownMenuItem(
                          value: snack,
                          child: Text('$snack'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _currentSnacks = val;
                        });
                      },
                      ),

                    SizedBox(
                      height: 20.0,
                    ),

                    //Slider
                    Slider(
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      onChanged: (val) {
                        setState(() {
                          _currentStrength = val.toInt();
                        });
                      },
                    ),

                    
                    RaisedButton(
                        color: Colors.brown,
                        splashColor: Colors.brown[400],
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          print(_currentName);
                          print(_currentSugars);
                          print(_currentStrength);
                          print(_currentCoffees);
                          print(_currentSnacks);
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentSugars ?? userData.sugars,
                                _currentName ?? userData.name,
                                _currentCoffees ?? userData.coffees,
                                _currentSnacks ?? userData.snacks,
                                _currentStrength ?? userData.strength
                                );
                            Navigator.pop(context);
                          }
                        })
                  ],
                ));
          } else {
            return Loading();
          }
        });
  }
}
