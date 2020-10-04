import 'package:coffeewala_app/models/brew.dart';
import 'package:coffeewala_app/screens/home/brew_list.dart';
import 'package:coffeewala_app/screens/home/settings_form.dart';
import 'package:coffeewala_app/screens/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffeewala_app/screens/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          },
          isScrollControlled: true,
          );
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text("CoffeeWala"),
          elevation: 1.0,
          actions: <Widget>[

            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/img');
              },
              child: Icon(Icons.image, color: Colors.white,)
          ),

          SizedBox(width: 30.0,),

          GestureDetector(
              onTap: (){
                _showSettingsPanel();
              },
              child: Icon(Icons.add_circle, color: Colors.white,)
          ),

          SizedBox(width: 30.0,),
           
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              label: Text("LogOut", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body: Container(
          child: BrewList(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.7), BlendMode.darken),
                  image: AssetImage("assets/coffee_hp.jpg"),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
