import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'en.dart';
import 'hu.dart';

class AlwaysAccessMemoryLocalizations {
  final Locale locale;

  AlwaysAccessMemoryLocalizations(this.locale);

  static AlwaysAccessMemoryLocalizations of (BuildContext context) {
    return Localizations.of<AlwaysAccessMemoryLocalizations>(
        context, AlwaysAccessMemoryLocalizations);
  }

  static LocalizationsDelegate<AlwaysAccessMemoryLocalizations> delegate = AlwaysAccessMemoryLocalizationsDelegate();

  static Map<String, Map<String, String>> _localizedValues = {
    'en': ENGLISH_LOCALIZATIONS,
    'hu': HUNGARIAN_LOCALIZATIONS,
  };

  String stringById(String id) => _localizedValues[locale.languageCode][id];
}

class AlwaysAccessMemoryLocalizationsDelegate extends LocalizationsDelegate<AlwaysAccessMemoryLocalizations> {
  @override
  bool isSupported(Locale locale) => ['en', 'hu'].contains(locale.languageCode);

  @override
  Future<AlwaysAccessMemoryLocalizations> load(Locale locale) {
    return SynchronousFuture<AlwaysAccessMemoryLocalizations>(AlwaysAccessMemoryLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AlwaysAccessMemoryLocalizations> old) => false;
}