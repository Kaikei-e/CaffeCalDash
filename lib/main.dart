import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final numController = TextEditingController();

  int _NumOfDrinks = 0;
  //static const IconData tea_cup = IconData(0xf1a6, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      key: _formkey,
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
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(30),
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: numController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 2,
                      onFieldSubmitted: (value) {
                        this._NumOfDrinks = int.parse(value);
                      },
                      onChanged: (value) {
                        _NumOfDrinks = int.parse(value);
                      },
                      onSaved: (value) {
                        _NumOfDrinks = int.parse(value!);
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.emoji_food_beverage_sharp,
                            color: Colors.white70),
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
                          vertical: 14.0, horizontal: 20.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white70),
                        ),
                        onPressed: () {
                          final _numDrinks = numController.text;
                          _NumOfDrinks = int.parse(_numDrinks);
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white70,
                      ),
                      child: Text(
                        'Number of drinks : $_NumOfDrinks',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
