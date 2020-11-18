import 'dart:async';

import 'package:always_access_memory/Services/LocationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NoteMap extends StatefulWidget {
  final String address;
  NoteMap(this.address);

  @override
  State<StatefulWidget> createState() => _NoteMapState();
}

class _NoteMapState extends State<NoteMap> {
  Completer<GoogleMapController> _controller = Completer();

  Future<CameraPosition> getAddressPosition(String address) async {
    LatLng location = await LocationService.find(address);
    return CameraPosition(target: location, zoom: 16);
  }

  @override
  Widget build(BuildContext context) {
    Future<CameraPosition> cameraPositionFuture = getAddressPosition(widget.address);
    return FutureBuilder(
      future: cameraPositionFuture,
      builder: (BuildContext context, AsyncSnapshot<CameraPosition> snapshot) {
        CameraPosition cameraPosition = snapshot.data;
        if(snapshot.connectionState == ConnectionState.done) {
          return new Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)),
            elevation: 16,
            child: Container(
              height: 400.0,
              width: 360.0,
              child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: cameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          );
        }
        return new Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40)),
          elevation: 16,
          child: Container(
            height: 400.0,
            width: 360.0,
            child: CircularProgressIndicator()
          ),
        );
      },
    );
  }

}