import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class FetchLiveAddress {
  final String _googleMapsApiKey = 'AIzaSyDsxERJWQN60820DxI50TEcsUd-PE7A404';

  Future<String> fetchAddress(LatLng position) async {
    late String selectedAddress;
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$_googleMapsApiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        selectedAddress = data['results'][0]['formatted_address'];
      } else {
        selectedAddress = 'Address not found';
      }
    } else {
      selectedAddress = 'Failed to fetch address';
    }
    return selectedAddress;
  }
}
