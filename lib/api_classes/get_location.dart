import 'package:geolocator/geolocator.dart';

class GetLocation {
  Future<Position> getPosition() async {
    bool isEnabled;
    LocationPermission permission;

    //Checking for service Enabling
    isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission Denied.");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Permssion Denies Forever.");
    }

    return await Geolocator.getCurrentPosition();
  }
}
