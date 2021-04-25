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

  String _valueTimeChanged = '';
  String _valueToValidate = '';

  int _numOfDrinks = 0;
  //static const IconData tea_cup = IconData(0xf1a6, fontFamily: 'MaterialIcons');


  @override
  void initState() {
    super.initState();
    _timeController = TextEditingController(text: DateTime.now().toString());
    //_getValue();
  }

/*
  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = '2000-10-22 14:30';
        _timeController.text = '2002-11-22';
      });
    });
  }
*/


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
                          vertical: 18.0, horizontal: 4.0),
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
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white70,
                      ),
                      child: Text(
                        'Number of drinks : $_numOfDrinks',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemBuilder: (BuildContext context, int index){
                        if (index >= list.length)
                      }),




                      
                    DateTimePicker(
                      type: DateTimePickerType.dateTime,
                      dateMask: 'yyyy/MM/dd - hh:mm',
                      controller: _timeController,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: Icon(Icons.event),
                      dateLabelText: 'Date',
                      timeLabelText: 'Hour',
                      selectableDayPredicate: (date) {
                        if (date.weekday == 6 || date.weekday == 7) {
                          return false;
                        }
                        return true;
                      },
                      onChanged: (val) =>
                          setState(() => _valueTimeChanged = val),
                      validator: (val) {
                        setState(() {
                          _valueToValidate = val ?? '';
                        });
                      },
                    )
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
