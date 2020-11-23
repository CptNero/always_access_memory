import 'dart:convert';
import 'dart:typed_data';

import 'package:always_access_memory/display_picture_fullscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imageAsBase64;

  DisplayPictureScreen({Key key, this.imageAsBase64}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Uint8List _bytesImage;
  Image image;

  @override
  void initState() {
    super.initState();
    _bytesImage = Base64Decoder().convert(widget.imageAsBase64);
    image = Image.memory(_bytesImage,);
    controller = AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
        ..addListener(() {
          setState(() {

          });
        });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        width: animation.value,

        height: animation.value,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => DisplayPictureFullscreen(_bytesImage))),
            child: image
        )
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}