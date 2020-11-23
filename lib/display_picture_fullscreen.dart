import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DisplayPictureFullscreen extends StatelessWidget {
  final Uint8List _bytesImage;
  DisplayPictureFullscreen(this._bytesImage);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.memory(_bytesImage, fit: BoxFit.cover, width: double.infinity, height: double.infinity,)
      ),
    );
  }
}
