import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  static const IconData tea_cup = IconData(0xf1a6, fontFamily: 'MaterialIcons');


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'CaffeCalDash',
      theme: ThemeData(
        fontFamily: "SF-Mono",
        primaryColor: Colors.blueGrey[800],
        accentColor: Colors.blueGrey[600],
      ),
      home: Stack(
        children: <Widget>[
          new Container(
            height: double.infinity,
            width: double.infinity,
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("images/cup_books.jpg"),
                    fit: BoxFit.cover)),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: new AppBar(
              title: Text("CaffeCalDash"),
              backgroundColor: Colors.brown[100]!.withOpacity(0.5),
              elevation: 0.0,
            ),
            body: Container(
              color: Colors.transparent,
              child: Column(
                key: _formKey,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                  icon: Icon(tea_cup)
              ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some value.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Proccesind Data')));
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
