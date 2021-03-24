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
        primaryColor: Colors.blueGrey[100],
        accentColor: Colors.white,
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
                      icon: Icon(
                        tea_cup,
                        color: Colors.white,
                        size: 30,
                      ),
                      labelText:
                          'Enter the number of drinks you want to calculate',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some value.';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white30),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Proccesind Data')));
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
