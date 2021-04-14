import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //static const IconData tea_cup = IconData(0xf1a6, fontFamily: 'MaterialIcons');

  Widget build(BuildContext context) {
    return MultiProvider(
      provider: [
        ChangeNotifierProvider<DrinkNumProvider>(
          create: (context) => DrinkNumProvider(),
        ),
      ],
      child: GetMaterialApp(
        home: HomePage(),
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}


class _HomePageState extends State<HomePage> with WidgetsBindingObserver{
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override

}


  final _formkey = GlobalKey<FormState>();
  final numController = TextEditingController();

  int _NumOfDrinks = 0;


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
  MaterialStateProperty.all(Colors.white60),
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
  Text(
  'Number of drinks are $_NumOfDrinks',
  style: TextStyle(
  backgroundColor: Colors.white30,
  color: Colors.black87,
  fontSize: 18,
  ),
  ),
  ],
          ),
        ),
      ),
    ),
  ],
}