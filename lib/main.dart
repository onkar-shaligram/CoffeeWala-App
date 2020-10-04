import 'package:coffeewala_app/models/user.dart';
import 'package:coffeewala_app/screens/image.dart';
import 'package:coffeewala_app/screens/services/auth.dart';
import 'package:coffeewala_app/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes : {
        '/img' : (context) => Img()
    }
      ),
    );
  }
}
