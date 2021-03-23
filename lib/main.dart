import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'CaffeCalDash',
      theme: ThemeData(
        fontFamily: "SF-Mono"
      ),
      home: Stack(
        children: <Widget>[
          new Container(
            height: double.infinity,
            width: double.infinity,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("images/cup_books.jpg"),
              fit: BoxFit.cover)
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: new AppBar(
              title: Text("CaffeCalDash"),
              backgroundColor: Colors.brown[100].withOpacity(0.5),
              elevation: 0.0,
            ),
            body: Container(
              color: Colors.transparent,
            ),
          )
        ],
      ),
    );

  }

}