import 'package:always_access_memory/I10n/localizations.dart';
import 'package:always_access_memory/Models/LanguageModel.dart';
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
          title: Text(AamLocalizations.of(context).stringById('settings')),
        ),
        body:
        Center(
          child: Column(
            children: [
            ListTile(
              title: Text(AamLocalizations.of(context).stringById('language')),
              trailing: DropdownButton<String>(
                  value: currentLanguage ?? Localizations.localeOf(context).languageCode,
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
                  items: <LanguageModel>{LanguageModel(name: AamLocalizations.of(context).stringById('hungarian'), locale: "hu"), LanguageModel(name: AamLocalizations.of(context).stringById('english'), locale: "en")}
                      .map<DropdownMenuItem<String>>((LanguageModel language) {
                    return DropdownMenuItem<String>(
                      key: Key(language.name),
                      value: language.locale,
                      child: Text(language.name),
                    );
                  }).toList()
              )
            ),
            ],
          ),
        )
    );
  }
}