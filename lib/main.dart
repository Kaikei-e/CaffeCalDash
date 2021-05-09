import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
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

  List<String> caffeDate = [];

  var list = [
    DateTime.now().toString(),
  ];

  String _valueTimeChanged = '';
  String _valueToValidate = '';

  int _numOfDrinks = 1;
  int _compareNumDrinks = 1;
  //static const IconData tea_cup = IconData(0xf1a6, fontFamily: 'MaterialIcons');

  @override
  void initState() {
    super.initState();
    _numOfDrinks = 1;
    var _dateNow = DateTime.now();
    _timeController = TextEditingController(
        text: DateFormat('yyyy/MM/dd(E) HH:mm').format(_dateNow).toString());
    _getValue();
  }

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = '2000-10-22 14:30';
        _timeController.text =
            DateFormat('yyyy/MM/dd(E) HH:mm').format(DateTime.now()).toString();
      });
    });
  }

  Widget _datetimeForm(BuildContext context, int _listCaffeIndex) {
    _listCaffeIndex = _listCaffeIndex - 1;
    caffeDate.add(_timeController.text);

    return ColoredBox(
        color: Colors.brown[100]!.withOpacity(0.7),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          height: 40,
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2021, 1, 1, 0, 0),
                        maxTime: DateTime(2022, 12, 31, 0, 0),
                        theme: DatePickerTheme(
                            headerColor: Colors.brown[200]!,
                            backgroundColor: Colors.lightGreen[200]!,
                            itemStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle:
                                TextStyle(color: Colors.black87, fontSize: 16)),
                        onChanged: (date) {
                      print('change $date in time zone ' +
                          date.timeZoneOffset.inHours.toString());
                      setState(() {
                        String _dateFormatted = DateFormat('yyyy/MM/dd(E) HH:mm').format(date);
                        caffeDate[_listCaffeIndex] = _dateFormatted;
                      });
                    }, onConfirm: (date) {
                      setState(() {
                        String _dateFormatted = DateFormat('yyyy/MM/dd(E) HH:mm').format(date);
                        caffeDate[_listCaffeIndex] = _dateFormatted;
                      });
                      print('confirm $date');
                    }, locale: LocaleType.en);
                  },
                  child: Text(
                    caffeDate[_listCaffeIndex],
                    style: TextStyle(color: Colors.black87),
                  )),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: new BoxDecoration(
                    border: new Border(bottom: BorderSide(width: 2)),
                  ),
                  child: Text(
                    "this is test",
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ));
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
        const SwitchLocalizationsDelegate(),
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
                padding: const EdgeInsets.all(10),
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
                          this._compareNumDrinks = this._numOfDrinks;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          this._numOfDrinks = int.parse(value);
                          this._compareNumDrinks = this._numOfDrinks;

                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          this._numOfDrinks = int.parse(value!);
                          this._compareNumDrinks = this._numOfDrinks;
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
                          vertical: 5.0, horizontal: 5.0),
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
                      margin: EdgeInsets.all(5),
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
                      margin: EdgeInsets.all(5),
                      child: Scrollbar(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            var listCaffe =
                                List.generate(_numOfDrinks, (i) => i + 1);
                            if (index >= listCaffe.length) {
                              list.addAll([]);
                            }

                            if (_compareNumDrinks != _numOfDrinks) {
                              caffeDate.clear();
                            }

                            return _datetimeForm(context, listCaffe[index]);
                          },
                          itemCount: _numOfDrinks,
                        ),
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

class Localized {
  Localized(this.locale);

  final Locale locale;

  static Localized? of(BuildContext context) {
    return Localizations.of<Localized>(context, Localized);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'CaffeCalDash: A simple caffeine calculator',
    },
    'ja': {
      'title': 'CaffeCalDash: カフェイン計算機',
    },
  };

  String? get title {
    return _localizedValues[locale.languageCode]!['title'];
  }
}

class SwitchLocalizationsDelegate extends LocalizationsDelegate<Localized> {
  const SwitchLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<Localized> load(Locale locale) async => Localized(locale);

  @override
  bool shouldReload(SwitchLocalizationsDelegate old) => false;
}
