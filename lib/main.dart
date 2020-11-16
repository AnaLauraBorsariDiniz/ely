import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/listview_cidade.dart';


void main() => runApp(
      MaterialApp(
        title: 'Carregando dados',
        home: ListViewCidade(),
      ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Saving data'),),
      body: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Read'), onPressed: () {_read();},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Save'), onPressed: () {_save();},
            ),
          ),
        ],
      ),
    );
  }
}

_read() async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getInt('my_int_key') ?? 0;
  print('read: $value');
}

_save() async {
  final prefs = await SharedPreferences.getInstance();
  final value = 42;
  prefs.setInt('my_int_key', value);
  print('saved $value');
}