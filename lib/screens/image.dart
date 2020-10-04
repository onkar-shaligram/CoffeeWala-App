import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Img extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'CoffeeWala';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text(title),
        ),
        body: Center(
          child: PhotoView(
                      imageProvider: AssetImage("assets/coffee_menu.jpg")
          ),
        ),
      ),
    );
  }
}