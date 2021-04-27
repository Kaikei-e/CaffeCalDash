import 'dart:html';
import 'dart:ui';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formkey = GlobalKey<FormState>();
  final numController = TextEditingController();
  late TextEditingController _timeController;

  var list = [
    DateTime.now().toString(),
  ];

  String _valueTimeChanged = '';
  String _valueToValidate = '';

  int _numOfDrinks = 1;
  //static const IconData tea_cup = IconData(0xf1a6, fontFamily: 'MaterialIcons');

  @override
  void initState() {
    super.initState();
    _numOfDrinks = 1;
    _timeController = TextEditingController(text: DateTime.now().toString());

    _getValue();
  }

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = '2000-10-22 14:30';
        _timeController.text = DateTime.now().toString();
      });
    });
  }

  Widget _datetimeForm() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: new BoxDecoration(
        color: Colors.brown[100],
        border: new Border(bottom: BorderSide(width: 2, color: Colors.black87)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: <Widget>[TextButton(onPressed: () {

        }, child: child)],
      ),
    );
  }

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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ja', ''),
      ],
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
              title: Text(
                "CaffeCalDash",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
                        setState(() {
                          this._numOfDrinks = int.parse(value);
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          this._numOfDrinks = int.parse(value);
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          this._numOfDrinks = int.parse(value!);
                        });
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
                          vertical: 18.0, horizontal: 10.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white70),
                        ),
                        onPressed: () {
                          final _numDrinks = numController.text;
                          this._numOfDrinks = int.parse(_numDrinks);
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white70.withOpacity(0.5),
                      ),
                      child: Text(
                        'Number of drinks : $_numOfDrinks',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Card(
                      color: Colors.white70.withOpacity(0.5),
                      margin: EdgeInsets.all(10),
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          var listCaffe =
                              List.generate(_numOfDrinks, (i) => i + 1);
                          if (index >= listCaffe.length) {
                            list.addAll([]);
                          }
                          return _datetimeForm();
                        },
                        itemCount: _numOfDrinks,
                      ),
                    )),
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
