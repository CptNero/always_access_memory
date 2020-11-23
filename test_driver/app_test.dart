import 'package:flutter/foundation.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Always Access Memory app', () {
    final addNoteButtonFinder = find.byKey(Key("AddNoteButton"));
    final submitNoteButtonFinder = find.byKey(Key("SubmitNoteButton"));
    final errorMessageFinder = find.byKey(Key("NoteNameFormField"))

    FlutterDriver driver;

    setUpAll((() async {
      driver = await FlutterDriver.connect();
    }));

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('handles mandatory fields', () async {
      await driver.tap(addNoteButtonFinder);
      await driver.tap(submitNoteButtonFinder);
      expect(await driver.getText(errorMessageFinder), "Field is mandatory");
    });

  });
}