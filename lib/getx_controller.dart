import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStateController extends GetxController {
  // RxString bookingFilter = "".obs;
  RxList<String> bookingFilterList = <String>[].obs;
}

class AppWidgets {
  snackbar({heading, required text}) {
    showDialog(
      context: Get.context as BuildContext,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          child: Container(
            width: 200,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(heading ?? "Alert", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                const SizedBox(height: 12),
                Text(
                  text.toString().contains("https:") ? "some error occurred" : text.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Divider(color: Colors.black45.withOpacity(0.2)),
                const SizedBox(height: 10),
                InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => Get.back(),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Text('Continue', style: TextStyle(color: Colors.blue, fontSize: 12.0, fontWeight: FontWeight.bold))],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
