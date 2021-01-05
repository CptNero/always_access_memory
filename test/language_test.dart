import 'dart:ui';

import 'package:always_access_memory/I10n/localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Language', () {
    test("Test translation", () {
      AamLocalizations huLocalizations = AamLocalizations(Locale("hu"));
      String editString = huLocalizations.stringById("editNote");
      expect(editString, "Jegyzet szerkesztése");
    });
  });
}