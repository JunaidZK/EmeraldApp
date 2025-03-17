import 'package:emerald_beauty/api_classes/categories/categories.dart';
import 'package:emerald_beauty/api_classes/get_location.dart';
import 'package:emerald_beauty/app_init/network_service.dart';
import 'package:emerald_beauty/constant_values/enums.dart';
import 'package:emerald_beauty/constant_values/location.dart';
import 'package:emerald_beauty/firebase/messaging.dart';
import 'package:emerald_beauty/firebase_options.dart';
import 'package:emerald_beauty/model_class/categories/category_response.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';

class AppInit {
  static late List<CategoryResponse> categories;

  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    NetworkService.initalizeUrl(Environment.staging);

    Categories cat = Categories();
    categories = (await cat.getCategories()) ?? [];

    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

    // Initialize Firebase Messaging
    Messaging msg = Messaging();
    await msg.setupForFirebase();

    final locationService = GetLocation();
    getloction = await locationService.getPosition();
    lat = getloction.latitude;
    lng = getloction.longitude;
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    address =
        "${placemarks[0].name ?? ""}, ${placemarks[0].street ?? ""}, ${placemarks[0].administrativeArea ?? ""}, ${placemarks[0].country ?? ""}";
  }
}

Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
  debugPrint("Handling background message: ${message.messageId}");
}
