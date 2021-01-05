import 'dart:convert';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationService {
  static Future<LatLng> find(String address, {http.Client httpClient}) async {
    var response = await http.get(_buildUrl(address));
    if (response.statusCode == HttpStatus.ok) {
      var data = jsonDecode(response.body);
      if (data.length > 0) {
        return LatLng(double.parse(data[0]['lat']), double.parse(data[0]['lon']));
      }
    }
    return LatLng(46.2587, 20.14222);
  }

  static String _buildUrl(String address) {
    var splitAddress = address.split(";");
    return
      'https://nominatim.openstreetmap.org/search?format=json&counrty=Hungary&city=${splitAddress[0]}&street=${splitAddress[2]} ${splitAddress[1]}';
  }

}