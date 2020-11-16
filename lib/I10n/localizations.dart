import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'en.dart';
import 'hu.dart';

class AamLocalizations {
  final Locale locale;

  AamLocalizations(this.locale);

  static AamLocalizations of (BuildContext context) {
    return Localizations.of<AamLocalizations>(
        context, AamLocalizations);
  }

  static LocalizationsDelegate<AamLocalizations> delegate = AamLocalizationsDelegate();

  static Map<String, Map<String, String>> _localizedValues = {
    'en': ENGLISH_LOCALIZATIONS,
    'hu': HUNGARIAN_LOCALIZATIONS,
  };

  String stringById(String id) => _localizedValues[locale.languageCode][id];
}

class AamLocalizationsDelegate extends LocalizationsDelegate<AamLocalizations> {
  @override
  bool isSupported(Locale locale) => ['en', 'hu'].contains(locale.languageCode);

  @override
  Future<AamLocalizations> load(Locale locale) {
    return SynchronousFuture<AamLocalizations>(AamLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AamLocalizations> old) => false;
}