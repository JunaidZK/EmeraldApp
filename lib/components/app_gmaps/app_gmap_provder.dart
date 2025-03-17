import 'package:emerald_beauty/components/app_gmaps/live_address/fetch_address.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../api_classes/get_location.dart';

class AppGMapProvider extends ChangeNotifier {
  late GoogleMapController mapController;
  late LatLng pickedLocation;
  Marker? locationMarker;
  bool _isLoading = true;
  TextEditingController selectedAddress = TextEditingController();
  FetchLiveAddress address = FetchLiveAddress();

  bool get isLoading => _isLoading;

  Future<void> getCurrentLocation() async {
    try {
      GetLocation location = GetLocation();
      Position position = await location.getPosition();
      pickedLocation = LatLng(position.latitude, position.longitude);
      selectedAddress.text = await address.fetchAddress(pickedLocation);

      locationMarker = Marker(
        markerId: const MarkerId('selected_location'),
        position: pickedLocation,
        infoWindow: InfoWindow(title: selectedAddress.text),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> selectLocation(LatLng position) async {
    pickedLocation = position;
    selectedAddress.text = await address.fetchAddress(position);

    locationMarker = Marker(
      markerId: const MarkerId('selected_location'),
      position: pickedLocation,
      infoWindow: InfoWindow(title: selectedAddress.text),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    );

    notifyListeners();
  }
}
