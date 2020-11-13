import 'package:always_access_memory/I10n/localizations.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String currentLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body:
        Center(
          child: Column(
            children: [
            DropdownButton<String>(
            value: currentLanguage,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.red),
            underline: Container(
                height: 2,
                color: Colors.redAccent
            ),
            onChanged: (String selectedLanguage) {
              setState(() {
                MyApp.setLocale(context, Locale(selectedLanguage, ''));
              });
            },
            items: <String>["en", "hu"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()
            )],
          ),
        )
    );
  }
}